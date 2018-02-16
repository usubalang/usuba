##
##################################################################
##   File "strucmac.s"
##################################################################
##
## Contents: a set of macro definitions that allow structured 
##   programming constructs in x86 assembler programs. These
##   constructs may be nested, up to a depth defined in the
##   macro __macLvl.
##
## Author: Doug Whiting, Hifn, 2005.
##
## This source code is released to the public domain.
##
## Target: This version works under the GNU assembler "as"
##
## Programming Constructs:
##----------------------------------------------------------------
## LOOPS: // how to use them
##----------------------------------------------------------------
##   _rept       [cnd]       #repeat, if [cnd] is true (blank --> TRUE)
##   #_reptStart:            #virtual label
##     ...
##     _break    [cnd]       #same as "j[cnd] _reptEnd"
##     ...
##     _begin    [cnd]       #same as "j[cnd] _reptStart"
##     ...
##   _endr                   #back to _reptStart (always)
##     # OR
##   _until      [cnd]       #back to _reptStart if [cnd] is true
##   #_reptEnd:              #virtual label -- end of loop block
##
##----------------------------------------------------------------
## CONDITIONALS: // how to use them
##----------------------------------------------------------------
##   _if         [cnd]
##     ...
##     _ifbrk    [cnd]       #same as "j[cnd] _ifExit"
##     ...       
##     _elbrk    [cnd]       #same as "j[cnd] _elseStart"
##     ...
##   _else       [cnd]       #else clause. If [cnd] false, fall thru into else
##   #_elseStart:            #virtual label
##     ...       
##     _ifbrk    [cnd]       #same as "j[cnd] _ifExit"
##     ...       
##   _endif                  #end of _if statemment      
##   #_ifExit:               #virtual label
##
##-----------------------------------------------------------------------------
## Note: _begin, _break, _ifbrk, and _elbrk all take an optional second 
##       parmeter, after the <cnd> parm, indicating how many levels to break 
##       out of. The default value is 0, and a value of 1 means to break out
##       of the surrounding level (not the current level). A value of 2 means
##       to break out of the second surrounding level, etc.
##-----------------------------------------------------------------------------

##
## define psuedo-opcodes for various flavors of jumps
##
.macro jnna target
    ja  \target
.endm

.macro jnnbe target 
    jbe \target 
.endm

.macro jnnae target 
    jae \target 
.endm

.macro jnnb target  
    jb  \target 
.endm

.macro jnnc target
    jc  \target
.endm

.macro jnne target  
    je  \target 
.endm

.macro jnnz target
    jz  \target
.endm

.macro jnng target
    jg  \target
.endm

.macro jnnle target
    jle \target
.endm

.macro jnnge target
    jge \target
.endm

.macro jnnl target
    jl  \target
.endm

.macro jnno target
    jo  \target
.endm

.macro jnns target
    js  \target
.endm

.macro jnnp target
    jp  \target
.endm

.macro jnnpo target
    jpo \target
.endm

.macro jnnpe target
    jpe \target
.endm

.macro j target
    jmp \target
.endm

.macro jnecnx target
    jecxz \target
.endm

.macro jn target
    ## do nothing
.endm

##
## Splice a bunch of strings together
##
.macro _concat aa,bb,cc dd,ee
\aa\bb\cc\dd\ee
.endm

##
## Because GNU as (apparently) does not have the ability to convert a formal
## parameter to its numeric value (e.g., like the % operator in MASM/TASM), 
## we need a "switch" statement to convert lvl to a digit.    :-(
##
## Note: if GNU as did have such an operator, there would be no need
##       for __macLvl, and the nesting level would be unlimited.
##
.macro  __macLvl    mac,lvl,aa,bb
    .if     (\lvl) == 1
      \mac  1,"\aa","\bb"   # call with \lvl converted to a number
    .elseif (\lvl) == 2
      \mac  2,"\aa","\bb"
    .elseif (\lvl) == 3
       \mac 3,"\aa","\bb"
    .elseif (\lvl) == 4
      \mac  4,"\aa","\bb"
    .elseif (\lvl) == 5
      \mac  5,"\aa","\bb"
    .else                   # only 5 levels of nesting supported
    .err    "Invalid level: '\mac \lvl,\aa,\bb'"
    .endif                  # (can add more levels if needed)
.endm

##
#################################################################
## assemble-time variables
#################################################################
##
.set    __ifLevel,0         # initialize the if level variable
.set    __gotElse,0         # initialize the else check (bitmap)
.set    __reptLvl,0         # initialize the rept level variable

##
#################################################################
## if/else/endif/ifbrk/elbrk definitions
#################################################################
##
##================ internal macros
.macro  __doIf  _level_,_cond_,_dummy_
    _concat  "jn",\_cond_," 990\_level_",f  # jump to else clause (forward)
    .set    __gotElse,__gotElse<<1          # push a '0' onto the bit "stack"
.endm

.macro  __doIfBrk _level_,_cond_,_dummy_
    _concat  "j",\_cond_," 980\_level_",f   # break out of if clause
.endm

.macro  __doElBrk _level_,_cond_,_dummy_
    _concat  "j",\_cond_," 990\_level_",f   # break to else clause
.endm

.macro  __doElse _level_,_cond_,_dummy_
  .if (__gotElse & 1)
     .err "Cannot have multiple else clauses!"
  .endif
    _concat  "j",\_cond_," 980\_level_",f   # jump past the _endif
    .set    __gotElse,__gotElse | 1         # push a '0' onto the gotElse bit "stack"
    _concat  "990\_level_",":"              # if not, instantiate the else target label
.endm

.macro  __doEndIf _level_,dummy1_,dummy2_
  .if (__gotElse & 1) == 0                  # was there an else clause?
    _concat  "990\_level_",":"              # if not, instantiate the else target label
  .endif
    _concat  "980\_level_",":"              # instantiate the endif target label
    .set    __gotElse,__gotElse>>1          # pop the gotElse bit "stack"
.endm

##================ "public" macros: call indirect via __macLvl
.macro  _if cond                            # start a conditional block
    .set    __ifLevel,__ifLevel+1           # bump the level
    __macLvl __doIf,__ifLevel,\cond
.endm

.macro  _endif                              # end a conditional block
    __macLvl __doEndIf,__ifLevel
    .set    __ifLevel,__ifLevel-1           # lower the level
.endm

.macro  _else cond                          # start the else clause
    __macLvl __doElse,__ifLevel,\cond
.endm

.macro  _ifbrk cond,brkLevel                # break out of the conditional
.set  blvl,\brkLevel-0                      # support multi-level ifbrk
    __macLvl __doIfBrk,__ifLevel-blvl,\cond
.endm

.macro  _elbrk cond,brkLevel                # "break" to the else clause
.set  blvl,\brkLevel-0                      # support multi-level elbrk
    __macLvl __doElBrk,__ifLevel-blvl,\cond
.endm

##
#################################################################
## rept/endr/until/break/begin
#################################################################
##
##================ internal macros
.macro  __doRept  _level_,_cond_,_dummy_
    _concat  "jn",\_cond_," 960\_level_",f  # conditional jump past endr
    _concat  "970\_level_",":"              # define the loop start point
.endm

.macro  __doEndr  _level_,_dummy1_,_dummy2_
    _concat  "jmp 970\_level_",b            # jump back to start of loop
    _concat  "960\_level_",":"              # define the loop end point
.endm

.macro  __doUntil  _level_,_cond_,_dummy_
    _concat  "jn",\_cond_," 970\_level_",b  # conditional jump back to start
    _concat  "960\_level_",":"              # define the loop end point
.endm

.macro  __doBreak  _level_,_cond_,_dummy_
    _concat  "j",\_cond_," 960\_level_",f   # conditional jump out of loop
.endm

.macro  __doBegin  _level_,_cond_,_dummy_
    _concat  "j",\_cond_," 970\_level_",b   # conditional jump back to start
.endm

##================ "public" macros: call indirect via __macLvl
.macro  _rept cond                          # start a new loop block
    .set    __reptLvl,__reptLvl+1           # bump to next loop level
    __macLvl __doRept,__reptLvl,\cond
.endm

.macro  _endr                               # end this loop
    __macLvl __doEndr,__reptLvl
    .set    __reptLvl,__reptLvl-1           # lower the level
.endm

.macro  _until cond                         # end loop, conditional jump back
    __macLvl __doUntil,__reptLvl,\cond
    .set    __reptLvl,__reptLvl-1
.endm

.macro  _break cond,brkLevel                # break out of current loop
.set blvl,\brkLevel-0                       # support multi-level break
    __macLvl __doBreak,__reptLvl-blvl,\cond
.endm

.macro  _brk cond,brkLevel                      # shorthand for _break
        _break \cond,\brkLevel
.endm

.macro  _begin cond,begLevel
.set blvl,\begLevel-0                       # support multi-level begin
    __macLvl __doBegin,__reptLvl-blvl,\cond
.endm

##
#################################################################
## end of file strucmac.S
#################################################################
##
