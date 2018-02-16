##
##----------------------------------------------------------------
## Phelix encryption/authentication algorithm
## Author: Doug Whiting, Hifn. 2005.
##
## This source code is released to the public domain
##----------------------------------------------------------------
##
    .file   "phelix86.S"
    .text
    .align 4
    
#ifndef __GNUC__                        /* using C pre-processor? */
    .include "strucmac.S"               ## structured programming macros
#else
#include "strucmac.S"                   /* follow C include path */
    .set _isDefined_,1                  ## useful for C defines
#ifdef   ECRYPT_API                     /* with ECRYPT switch? */
#define _ECRYPT_API _isDefined_
#endif
#ifdef   MIX_ASM
#define _MIX_ASM    _isDefined_
#endif
#endif

##
## concatenate text together (useful in building names inside macros)
.macro  strCat  aa,bb,cc,dd,ee,ff,gg,hh
\aa\bb\cc\dd\ee\ff\gg\hh
.endm
##----------------------------------------------------------------
## define a global label. Handle linking with and without underscore
.macro  C_global    phelixName,ecryptName
 \phelixName:		#use both "genders" to work across linkage conventions
_\phelixName:
  .ifdef _MIX_ASM   # rename with _ASM suffix to allow linking of C & asm together
    strCat ".global ",\phelixName,"_ASM"
    strCat ".global _",\phelixName,"_ASM"
strCat " ",\phelixName,"_ASM:"
strCat "_",\phelixName,"_ASM:"
  .else				#
    .global  \phelixName
    .global _\phelixName
	.ifdef _ECRYPT_API	# use ECRYPT names as well
	.ifnc \ecryptName,
	  .global  \ecryptName
	  .global _\ecryptName
	   \ecryptName:
	  _\ecryptName:
	.endif
	.endif
  .endif
.endm
##
##################################################################
##
C_global _debugPhelix_
        .long   0           #ignored here, but must be defined for testPhelix.c

AsmName:    .ascii  "gnu.as\0"
        .align 4
##
C_global PhelixCompiler_Name            #show who assembled us
        lea     AsmName,%eax
C_Global PhelixInit,ECRYPT_init         #Init call does nothing
        ret
##
##----------------------------------------------------------------
## Macros and definitions
##----------------------------------------------------------------
##
## Phelix rotation constants
    .set    ROT_0a,          9
    .set    ROT_1a,         10
    .set    ROT_2a,         17
    .set    ROT_3a,         30
    .set    ROT_4a,         13

    .set    ROT_0b,         20
    .set    ROT_1b,         11
    .set    ROT_2b,          5
    .set    ROT_3b,         15
    .set    ROT_4b,         25

    .set    UNROLL_CNT,      8              #how many blocks to unroll in inner loop
    .set    ZERO_INIT_CNT,   8              #number of words of init
    .set    MAGIC_MAC_XOR,   0x912d94f1     #special constants
    .set    MAGIC_AAD_XOR,   0xaadaadaa
##
##----- register assignments
## Z0       equ     eax
## Z1       equ     ebx
## Z2       equ     ecx
## Z3       equ     edx
## Z4       equ     esi
## t0       equ     ebp             #"temp" scratch registers
## t1       equ     edi
## oldZreg  equ     Z4
##
##----------------------------------------------------------------
##
## Allocate and define local variables on the stack
## [Note:   We use esp for locals, not ebp, since we need ebp as a variable.
##          Thus, we cannot use the assembler stack frame primitives.]
##
    .set    _maxLocalSize_      ,0      #max locals usage in bytes
    .set    _Phelix_LocalSize   ,0      #starting value: no locals allocated yet
    .set    _SO_                ,0      #current stack offset due to calls
##
.macro _newLocal    wCnt,lName          #macro to define a local variable
    .set    \lName           ,_Phelix_LocalSize
    .set    _Phelix_LocalSize,_Phelix_LocalSize+4*(\wCnt)
    ## keep running tabs on stack usage for locals
  .if    _maxLocalSize_<_Phelix_LocalSize
    .set _maxLocalSize_,_Phelix_LocalSize
  .endif
.endm
##
.macro  _newParm wCnt,_pp_
    .set \_pp_, _pOfs_
strCat   ".set ",\_pp_,_LCL,",",(_pOfs_-_cpOfs_)
    .set _pOfs_,_pOfs_+4*(\wCnt)
.endm
##
    ## now define local variables for the Encrypt/Decrypt functions
    _newLocal   1,srcPtr            #pointer to  input data buffer
    _newLocal   1,dstPtr            #pointer to output data buffer
    _newLocal   1,loopByteCnt       #inner loop byte counter
    _newLocal   1,jmpTabPtr         #pointer to encrypt/decrypt jump table
    _newLocal   8,X_i_0             #local copy of the key values
    _newLocal   8,X_i_1
    _newLocal   4,oldZ              #"old" Z values
    _newLocal   1,_i_               #block number (+8)
    _newLocal   UNROLL_CNT  ,exitTab#local jump table for exiting unrolled loop
    _newLocal   UNROLL_CNT+4,tmpBuf #local buffer encryption/decryption blocks
    _newLocal   1,aadLeft           ## bytes of aad remaining
    _newLocal   1,msgLen0           #initial value of src_ByteCnt
    _newLocal   1,dstPtr0           #initial dst pointer
    _newLocal   1,retAddr           #local "return" address

    .set    _cpOfs_,4+8*4+_Phelix_LocalSize #caller parms offset from esp
    .set        retAddr_LCL,retAddr-_cpOfs_
    .set        dstPtr0_LCL,dstPtr0-_cpOfs_
    .set        msgLen0_LCL,msgLen0-_cpOfs_
    .set         tmpBuf_LCL, tmpBuf-_cpOfs_
##
##----------------------------------------------------------------
## Define caller parameters on the stack, relative to esp
##
    .set    _pOfs_,_cpOfs_

    _newParm    0,callerParms       #placeholder, no space allocated
    _newParm    1,ctxt_Ptr          
    _newParm    1,nonce_Ptr
    _newParm    1,aad_Ptr
    _newParm    1,aad_Len
    _newParm    1,src_Ptr
    _newParm    1,dst_Ptr
    _newParm    1,src_ByteCnt
    _newParm    1,mac_Ptr
##
##----------------------------------------------------------------
## Phelix context structure definition
    .set    _pOfs_,0

    _newParm    1,keySize           #size of raw key in bits
    _newParm    1,macSize           #size of mac tag in bits
    _newParm    1,X_1_Bump          #4*(keySize/8) + 256*(macSize mod 128)
    _newParm    8,X_0               #subkeys
    _newParm    8,X_1               #subkeys
    ## internal cipher state
    _newParm    4,old_Z             #previous Z[4] values for output
    _newParm    5,_Z_               #5 internal state words
    _newParm    1,blkNum            #block number (i)
    _newParm    2,aadLen            #64-bit aadLen counter (LSW first)
    _newParm    1,msgLen            #32-bit msgLen counter (mod 2**32)
    _newParm    1,aadXor            #aad Xor constant
##
##----------------------------------------------------------------
##
.macro _o_  op1,op2,op3,cond3       #shorthand: instantiate 1-3 opcodes
        \op1
        \op2
        \op3
        \cond3
.endm
##----------------------------------------------------------------
## adjust _SO_ with push/pop operations
.macro  _stackOp op,reg,bump
    .ifnc  \reg,                #only do something if reg is not blank
      \op %\reg
      .set  _SO_,_SO_+\bump
    .endif
.endm

.macro  _push   r0,r1,r2,r3,r4,r5,r6
    _stackOp    push,\r0,4
    _stackOp    push,\r1,4
    _stackOp    push,\r2,4
    _stackOp    push,\r3,4
    _stackOp    push,\r4,4
    _stackOp    push,\r5,4
    _stackOp    push,\r6,4
.endm
##
.macro  _pop    r0,r1,r2,r3,r4,r5,r6
    _stackOp     pop,\r0,-4
    _stackOp     pop,\r1,-4
    _stackOp     pop,\r2,-4
    _stackOp     pop,\r3,-4
    _stackOp     pop,\r4,-4
    _stackOp     pop,\r5,-4
    _stackOp     pop,\r6,-4
.endm
##
##----------------------------------------------------------------
## Init code, jump tables (for lblName = Encrypt/Decrypt)
##----------------------------------------------------------------
##
.macro  PhelixAlgo lblName
        ## first, set up the stack frame
        pushal                          #save all regs on stack
 strCat "lea ",\lblName,"_jmpTab,%ebp"  #handle the encrypt/decrypt difference
        jmp     Phelix_Main             #go run the algorithm
        ##
        ## the jump table for this operation
        ##
        .align  4
strCat  \lblName,"_jmpTab:"
        ##first, a list of "block boundary" targets within unrolled processing loop
        .irp xxx,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
          .if \xxx < UNROLL_CNT
            strCat  " .long \lblName","Blk_",\xxx
strCat  " .global \lblName","Blk_",\xxx
          .endif
        .endr
        ## next, successive "control" targets within Phelix_Main
        strCat  ".set OddBytes_OFFS,","(.-\lblName","_jmpTab)"
        strCat  ".long \lblName","_OddBytes"
.endm   #PhelixAlgo

##
##----------------------------------------------------------------
## Common unrolled loop end code for encrypt/decrypt
##----------------------------------------------------------------
##
.macro PhelixEndLoop CNT
        addl    $(\CNT)*4,srcPtr(%esp)      #bump the pointers
        addl    $(\CNT)*4,dstPtr(%esp)           
        addl    $(\CNT)  ,_i_   (%esp)      #bump the count
        subl    $(\CNT)*4,loopByteCnt(%esp) #are we done yet?
.endm   #leave here with flags set for loop jmp
##
##----------------------------------------------------------------
## Common "early exit" code for encrypt/decrypt inner loop
##----------------------------------------------------------------
## This functionality is required for splicing AAD/text/padding
##
.macro PhelixEarlyExit  jTabReg,_bn_
    .if \_bn_ < (UNROLL_CNT-1)          #do not need early exit at bottom of loop
        testl %\jTabReg,%\jTabReg       #time to exit?
        _if  nz
          movl %esi,oldZ+4*((\_bn_) & 3)+_SO_(%esp)
          jmp *%\jTabReg                #go to "exit" address
        _endif
    .endif
    movl %esi,oldZ+4*((\_bn_)& 3)+_SO_(%esp)
.endm
##
##****************************************************************
## start of actual code (i.e., end of macro definitions)
##****************************************************************
##
        .align  4
INIT_ZEROES:
    .rept ZERO_INIT_CNT
            .long   0
    .endr
MASK_TAB:   .long   0,0xff,0xffff,0xffffff

_PhelixCodeStart_:

##
##----------------------------------------------------------------
## Common control path for Encrypt/Decrypt
##----------------------------------------------------------------
## In:  ebp --> (const) jump table (Encrypt_jmpTab or Decrypt_jmpTab)
## Out: everything done
##
Phelix_Main:
        ##point to callers first parameter (save code size below)
        leal    callerParms-_Phelix_LocalSize(%esp),%esi
        subl    $_Phelix_LocalSize,%esp #make room for locals on stack
        movl    %ebp,jmpTabPtr(%esp)    #save jump table pointer
        call    InitNonce
        ##
        ##################################################################
        ## Finally ready to start running Phelix on some data
        ##################################################################
        ## First, process the initialization zeroes (loopByteCnt == 0 from PhelixInit)
        ##
        movl    $_ret_InitZeroDone,exitTab+4*(ZERO_INIT_CNT-1)+_SO_(%esp)
        jmp     EncryptBlk_0
        ##
        ## "local" function
    .set _SO_,4
InitNonce:
        ## first, init the local keys on the stack
        movl    ctxt_Ptr_LCL(%esi),%ebp         #point to context structure
        movl    X_1_Bump(%ebp),%edi             #edi=4*(keySize/8)+256*(macSize mod 128)
        movl    nonce_Ptr_LCL(%esi),%edx        #(const) pointer to nonce words

        _push   esi                             #save esi  (push/pop = smaller than lea esi,callerParms)
        xor     %esi,%esi                       #use esi as the variable i in SetTwoKeys
        inc     %esi                            #start with i = 1, since edi = X_1 = 4*L(U) already
        call    SetTwoKeys                      #set X_1_n, X_5_n, for n=0,1  [return w/edi == 0]
        call    SetTwoKeys                      #set X_2_n, X_6_n, for n=0,1
        call    SetTwoKeys                      #set X_3_n, X_7_n, for n=0,1
        xor     %esi,%esi                       #wrap to i = 0
        call    SetTwoKeys                      #set X_0_n, X_4_n, for n=0,1
        _pop    esi                             #restore pointer to callerParms

        ##set up for initialization phase
        xorl    %ecx,%ecx   
        leal    INIT_ZEROES,%ebp                #use all zero input words, for i= -8 .. -1
        leal    tmpBuf+_SO_(%esp),%edi          #discard output
        movl    %ecx,loopByteCnt+_SO_(%esp)     #initialize loop byte count counter = 0
        movl    %ecx,_i_+_SO_(%esp)             #initialize i = 0 (block number + 8)
        movl    %ebp,srcPtr+_SO_(%esp)
        movl    %edi,dstPtr+_SO_(%esp)

        ## now initialize the Zn register values
        movl    ctxt_Ptr_LCL(%esi),%ebp
        movl    nonce_Ptr_LCL(%esi),%edi

        movl    X_0+12(%ebp),%eax               #get the X_0 key values
        movl    X_0+16(%ebp),%ebx
        movl    X_0+20(%ebp),%ecx
        movl    X_0+24(%ebp),%edx
        movl    X_0+28(%ebp),%esi

        xorl      (%edi),%eax                   #merge in the nonce
        xorl     4(%edi),%ebx
        xorl     8(%edi),%ecx
        xorl    12(%edi),%edx
        ret
.set _SO_,0
        ############################################
        ## done with the initial zeroes.
_ret_InitZeroDone:
    .if UNROLL_CNT > ZERO_INIT_CNT          #do we need to clear out the return point?
        xorl    %ebp,%ebp                   #(only if it is not already at the end)
        movl    %ebp,exitTab+4*(ZERO_INIT_CNT-1)+_SO_(%esp)
    .endif
        #################
        ## handle AAD here, looping if needed
        xorl    $MAGIC_AAD_XOR,%ebx
        movl    aad_Len+_SO_(%esp),%ebp
        testl   %ebp,%ebp
    _if nz                                  #if nothing there, skip all aad processing
        movl    aad_Ptr+_SO_(%esp),%edi
        movl    %ebp,aadLeft+_SO_(%esp)
        movl    %edi, srcPtr+_SO_(%esp)     #src will come from aad_Ptr
_aad_Loop:                                  #here with ebp == aad_Len
        leal    tmpBuf+_SO_(%esp),%edi      #always use tmpBuf for aad dst (discard)
        movl    %edi,dstPtr+_SO_(%esp)
        movl    aadLeft+_SO_(%esp),%ebp
        subl    $4*UNROLL_CNT,%ebp          #only do one unrolled loop each time
        _if ae                              #(since we use tmpBuf to discard ciphertext)
          movl  %ebp,aadLeft+_SO_(%esp)
          xorl  %edi,%edi
          movl  %edi,loopByteCnt+_SO_(%esp)
          movl  $_aad_Loop,exitTab+4*(UNROLL_CNT-1)+_SO_(%esp)
          jmp   EncryptBlk_0
        _endif
        ## here to handle final partial loop
_aad_PartialLoop:
        andl    $4*(UNROLL_CNT-1),%ebp
        movl    %ebp,loopByteCnt+_SO_(%esp)
        cmpl    $4,%ebp
        _if ae
          movl      $_ret_aad_1,exitTab-4+_SO_(%esp,%ebp)
          jmp       EncryptBlk_0
        _ret_aad_1:
          movl      loopByteCnt+_SO_(%esp),%ebp
          xorl      %edi,%edi
          movl      %edi,exitTab-4+_SO_(%esp,%ebp)  #clear the entry
        _endif
        ## here to handle final partial word of AAD
        movl    aadLeft+_SO_(%esp),%ebp
        movl    %ebp,%edi
        andl    $3,%edi                 #any odd bytes?
        _ifbrk  z                       #if not, we are done with AAD
        addl    $4,%ebp
        andl    $4*(UNROLL_CNT-1),%ebp
        movl    %ebp,loopByteCnt+_SO_(%esp)
        _push   esi
        subl    $4,%ebp
        andl    $4*(UNROLL_CNT-1),%ebp
        movl    srcPtr+_SO_(%esp),%esi
        movl    (%esi,%ebp),%esi        #get the last AAD word
        andl    MASK_TAB(,%edi,4),%esi  #clear out extra bits
        leal    tmpBuf+_SO_(%esp),%edi
        movl    %esi,(%edi)
        subl    %ebp,%edi
        movl    %edi,dstPtr+_SO_(%esp)
        movl    %edi,srcPtr+_SO_(%esp)
        movl    $_ret_aad_2,exitTab+_SO_(%esp,%ebp)
        movl    %ebp,tmpBuf+4+_SO_(%esp)#save this
        _pop    esi
        jmp     *Encrypt_jmpTab(%ebp)
_ret_aad_2:
        movl    tmpBuf+4+_SO_(%esp),%ebp
        xorl    %edi,%edi
        movl    %edi,exitTab+_SO_(%esp,%ebp)
    _endif
        xorl    $MAGIC_AAD_XOR,%ebx
        #################
        ## process the user data
_startUserData:
        _push   esi                         #use esi as temp pointer 
        leal    callerParms+_SO_(%esp),%esi #  (to save code size in accessing caller parms below)
        leal    _ret_MAC0,%ebp
        movl    %ebp,retAddr_LCL(%esi)
        movl    src_Ptr_LCL(%esi),%ebp
        movl    %ebp,srcPtr+_SO_(%esp)
        movl    dst_Ptr_LCL(%esi),%edi
        movl    src_ByteCnt_LCL(%esi),%ebp
        ## enter here from EncryptBytes
processUserData:
        movl    %edi,dstPtr+_SO_(%esp)
        movl    %edi,dstPtr0_LCL(%esi)
        movl    %ebp,msgLen0_LCL(%esi)
        _pop    esi                         #restore esi
        movl    loopByteCnt+_SO_(%esp),%edi
        andl    $4*(UNROLL_CNT-1),%edi      #get the loop "phase"
        subl    %edi,dstPtr+_SO_(%esp)      #adjust pointers accordingly
        subl    %edi,srcPtr+_SO_(%esp)
        #################
        ## now process the bulk of the data in "full" loop chunks (ebp = src_ByteCnt)
        addl    %edi,%ebp
        subl    $UNROLL_CNT*4,%ebp          #enough for one "full" loop?
        movl    %ebp,loopByteCnt+_SO_(%esp) #save the pre-subtracted value for use in the loop
        _if ae  
          add   jmpTabPtr+_SO_(%esp),%edi   #get ready to jump into block processing
          movl  $_ret_DataDone1,exitTab+4*(UNROLL_CNT-1)+_SO_(%esp)
          jmp   *(%edi)                     #go encrypt or decrypt
_ret_DataDone1:
          movl  loopByteCnt+_SO_(%esp),%ebp #restore ebp = loopByteCnt
          xorl  %edi,%edi                   #starting phase is at ??crypt_0 now
        _endif
        #################
        ## now process the remainder of the data, if any (partial loop)
        andl    $4*(UNROLL_CNT-1),%ebp      #compute ebp = end phase
        cmpl    %edi,%ebp                   #any partial loop to do?
        _if nz
          movl  %ebp,loopByteCnt+_SO_(%esp) #make sure that the exit loop test falls thru
          addl  jmpTabPtr+_SO_(%esp),%edi   #get ready to jump
          movl  $_ret_DataDone2,exitTab-4+_SO_(%esp,%ebp)   #force an exit at the correct point
          jmp   *(%edi)
_ret_DataDone2:
          xorl  %edi,%edi                   #edi = 0
          movl  loopByteCnt+_SO_(%esp),%ebp
          andl  $4*(UNROLL_CNT-1),%ebp      #recompute exitTab index
          movl  %edi,exitTab-4+_SO_(%esp,%ebp)  #clear the exitTab entry
        _endif
        #################
        ## special (i.e. UGLY!!) handling when src_ByteCnt is not a multiple of 4
        ## here with ebp = loopByteCnt AND 4*(UNROLL_CNT-1)
        movl    msgLen0+_SO_(%esp),%edi     #get original msgLen
        andl    $3,%edi                     #any partial words? (hopefully rare)
        _if nz
          movl  $_ret_OddBytes,exitTab+_SO_(%esp,%ebp)
          orl   %ebp,%edi                   #save word index and odd byte count
          movl  %edi,loopByteCnt+_SO_(%esp) #   back into loopByteCnt
          _push esi
          andl  $3,%edi
          movl  srcPtr+_SO_(%esp),%esi
          addl  %ebp,%esi
          _push ebp
          movl  MASK_TAB(,%edi,4),%edi      #get the mask bits
          movl  (%esi),%ebp                 #and get the source word
          leal  tmpBuf+_SO_(%esp),%esi
          andl  %edi,%ebp                   #ebp = masked source word
          movl  %edi,8(%esi)                #save the mask bits (for use in Decrypt_OddBytes)
          movl  %ebp, (%esi)                #save the masked source word
          _pop  ebp
          subl  %ebp,%esi                   #adjust src/dst ptrs for hard coded offsets in block code
          movl  %esi,srcPtr+_SO_(%esp)      #set up for "single-word" encrypt in tmpBuf[]
          addl  $4,%esi
          movl  %esi,dstPtr+_SO_(%esp)
          mov   jmpTabPtr+_SO_(%esp),%edi   #dispatch to different handler for Encrypt & Decrypt
          _pop  esi
          jmp   *OddBytes_OFFS(%edi)
          ##
          ## here to handle the odd-byte encrypt case
Encrypt_OddBytes:
          jmp   *Encrypt_jmpTab(%ebp)       #go encrypt the single word
          ##
          ## here to handle the funky odd-byte decrypt case
Decrypt_OddBytes:
          ## we have to encrypt halfway thru the block to compute keystream :-((
          ##        (i.e., in order to produce the "full" ciphertext word)
          _push eax,ebx,ecx,edx,esi,ebp
          _o_ "addl %edx,%eax","roll $ROT_3b,%edx","mov X_i_0+_SO_(%esp,%ebp),%ebp" #get the key word
          _o_ "addl %esi,%ebx","roll $ROT_4b,%esi"
          _o_ "xorl %eax,%ecx","roll $ROT_0a,%eax"
          _o_ "xorl %ebx,%edx"                   ,"add %edx,%ebp"
          _o_ "addl %ecx,%esi","roll $ROT_2a,%ecx","mov loopByteCnt+_SO_(%esp),%edi"
          
          _o_ "xorl %ebp,%eax","roll $ROT_4a,%esi","and $4*3,%edi"
          _o_ "addl %eax,%ecx"               ,"mov oldZ+_SO_(%esp,%edi),%ebp"
          _o_ "xorl %ecx,%esi"
          addl  %esi,%ebp                   #now ebp = keystream
          movl  tmpBuf+8+_SO_(%esp),%edi    #get the mask word
          notl  %edi                        #toggle the maskbits
          andl  %ebp,%edi                   #mask off unused maskbits
          xorl  %edi,tmpBuf+_SO_(%esp)      #re-create the "full" ciphertext word @ tmp src buffer
          _pop  ebp,esi,edx,ecx,ebx,eax
          jmp   *Decrypt_jmpTab(%ebp)       #go decrypt
          ## "return" here with the dest word computed at [tmpBuf+4]
_ret_OddBytes:
          _push esi,eax
          leal  callerParms+_SO_(%esp),%esi
          xorl  %edi,%edi
          movl  loopByteCnt+_SO_(%esp),%ebp
          andl  $4*(UNROLL_CNT-1),%ebp
          movl  %edi,exitTab+_SO_(%esp,%ebp)    #clear out the exitTab entry we just used
          movl  msgLen0+_SO_(%esp),%edi         #now output just the number of dst bytes specified
          movl  %edi,%ebp
          andl  $3,%ebp
          xorl  %ebp,%edi                       #clear low 2 bits of count
          addl  dstPtr0_LCL(%esi),%edi          #point to "final" word offset
          movl  tmpBuf_LCL+4(%esi),%eax         #get the dst output word (short offset)
          xorl  (%edi),%eax                     #do bit diddling to output just the odd bytes
          andl  MASK_TAB(,%ebp,4),%eax
          xorl  %eax,(%edi)
          _pop  eax,esi
        _endif
        jmp     *retAddr+_SO_(%esp)         #"return" to whomever
_ret_MAC0:
        #################
        ## here to compute and output/compare the MAC
        movl    mac_Ptr+_SO_(%esp),%ebp
        xorl    aad_Len+_SO_(%esp),%esi
processMAC: 
        movl    %ebp,dstPtr0+_SO_(%esp)     #save MAC ptr
        xorl    $MAGIC_MAC_XOR,%eax         #toggle bits to start the MAC
        _push   esi
        movl    loopByteCnt+_SO_(%esp),%ebp
        movl    %ebp,%edi
        addl    $3,%ebp                     #advance to next full word, if odd bytes
        andl    $4*(UNROLL_CNT-1),%ebp      #ebp = next word "offset" within block
        andl    $3,%edi                     #edi = length of src mod 4 (plaintext for MAC)
        leal    tmpBuf+_SO_(%esp),%esi
        .set _bb_,0
    .rept 12                                #8 for padding, 4 for MAC size
        movl    %edi,_bb_(%esi)             #fill tmpBuf with L(P) mod 4
        .set _bb_,_bb_+4
    .endr
        leal    7*4(%ebp),%edi
        andl    $4*(UNROLL_CNT-1),%edi      #stop point is after 8 blocks (i+0..i+7)
        movl    $_ret_MAC1,exitTab+_SO_(%esp,%edi)
        subl    %ebp,%esi                   #set up source/dest pointers
        movl    %esi,srcPtr+_SO_(%esp)
        movl    %esi,dstPtr+_SO_(%esp)
        addl    $8*4-1,%ebp                 #FUNKY wrap logic requires -1
        movl    %ebp,loopByteCnt+_SO_(%esp)
        incl    %ebp                        #undo adjustment
        andl    $4*(UNROLL_CNT-1),%ebp
        _pop    esi
        jmp     *Encrypt_jmpTab(%ebp)       #go do the encryption
        ## just finished eight blocks of "padding" using L(P) mod 4
        ## now generate the MAC
_ret_MAC1:
        movl    loopByteCnt+_SO_(%esp),%ebp
        incl    %ebp                        #undo the -1 above
        andl    $4*(UNROLL_CNT-1),%ebp
        leal    3*4(%ebp),%edi              #do four more (0..3 -- stop after #3)
        andl    $4*(UNROLL_CNT-1),%edi
        movl    $_ret_MAC2,exitTab+_SO_(%esp,%edi)
        leal    4*4-1(%ebp),%edi            #FUNKY wrap logic requires -1
        movl    %edi,loopByteCnt+_SO_(%esp)
        jmp     *Encrypt_jmpTab(%ebp)
        ##
        ## here with the MAC computed. eax..esi now can be trashed
_ret_MAC2:
        leal    callerParms+_SO_(%esp),%esi
        movl    ctxt_Ptr_LCL(%esi),%edi
        movl    macSize(%edi),%ecx          #ecx = # bits in MAC
        movl    dstPtr0_LCL(%esi),%edi
        leal    tmpBuf+8*4+_SO_(%esp),%esi
        testl   $31,%ecx                    #can we do it one word at a time?
        _if z
          shrl  $5,%ecx                     #if so, it is faster
          rep   movsl
        _else
          addl  $7,%ecx                     #round up to byte boundary
          shrl  $3,%ecx                     #non-word sizes get the slow treatment
          rep   movsb
        _endif
        #################
        ## tear down the stack and return
        addl    $_Phelix_LocalSize,%esp
        popal                               #restore all of callers regs
        ret                                 #and return to caller
##
##----------------------------------------------------------------
## Common subroutine (for use in Phelix_Main) to init subkeys
##----------------------------------------------------------------
## In:  ebp     --> pCtxt (const)   
##      edx     --> nonce (const)
##      edi     =   X value for I
##      esi     =   value of I (0..3)
## Out: esi incremented.  ebp, edx unmodified
##      edi     = oldZ[I] = 0
##      X_i_0, X_i_1 set on stack for both i=I and i=I+4
##      edi
.set _SO_,12                                        #two words on stack before call
SetTwoKeys:
        movl    X_0+4*0(%ebp,%esi,4),%eax           #load two key values
        movl    X_0+4*4(%ebp,%esi,4),%ebx
        movl    %eax,X_i_0+4*0+_SO_(%esp,%esi,4)    #store the X_i_0 values
        movl    %ebx,X_i_0+4*4+_SO_(%esp,%esi,4)
        movl    (%edx,%esi,4),%ecx                  #get ecx = N_i
        addl    %edi,%eax                           #add in 4*L(U), for esi == 1
        addl    %edi,%ebx
        addl    %ecx,%ebx                           #add/sub the nonce value
        subl    %ecx,%eax
        addl    %esi,%eax
        xorl    %edi,%edi                           #set edi = 0
        movl    %ebx,X_i_1+4*0+_SO_(%esp,%esi,4)    #store the X_i_1 values
        movl    %eax,X_i_1+4*4+_SO_(%esp,%esi,4)
        movl    %edi,oldZ+_SO_(%esp,%esi,4)         #zero out the oldZ values
        .set _NN_,0
    .rept UNROLL_CNT/4                              #init the "block exit" jump table: all zeroes
        movl    %edi,exitTab+_NN_+_SO_(%esp,%esi,4)
        .set _NN_,_NN_ + 16
    .endr
        incl    %esi                        #bump the counter for next call
        ret
##
.set _SO_,0                         #back to no offset
##
##----------------------------------------------------------------
## Encryption routines
##----------------------------------------------------------------
##
        .align  4
C_global PhelixEncryptPacket,ECRYPT_AE_encrypt_packet
        PhelixAlgo  Encrypt                 #instantiate the algorithm ocde
        ##
        ## the main block processing loop
        ##
    _rept
      .irp _blkNum_,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
       .if  \_blkNum_ < UNROLL_CNT
strCat  EncryptBlk_,\_blkNum_,":"           #make a label for re-entry points
        .set _bb_,\_blkNum_ & 7             #support UNROLL_CNT > 8

        _o_ "addl %edx,%eax","roll $ROT_3b,%edx","movl X_i_0+4*_bb_+_SO_(%esp),%ebp"
        _o_ "addl %esi,%ebx","roll $ROT_4b,%esi"
        _o_ "xorl %eax,%ecx","roll $ROT_0a,%eax","movl srcPtr+_SO_(%esp),%edi"
        _o_ "xorl %ebx,%edx","roll $ROT_1a,%ebx","addl %edx,%ebp"   #does LEA opcode help here?
        _o_ "addl %ecx,%esi","roll $ROT_2a,%ecx"

        _o_ "xorl %ebp,%eax","roll $ROT_3a,%edx","movl 4*_bb_(%edi),%ebp"   #ebp = plaintext
        _o_ "xorl %esi,%ebx","roll $ROT_4a,%esi","movl oldZ+4*(_bb_&3)+_SO_(%esp),%edi"
        _o_ "addl %eax,%ecx","roll $ROT_0b,%eax"
        _o_ "addl %ebx,%edx","roll $ROT_1b,%ebx","xorl %edx,%ebp"
        _o_ "xorl %ecx,%esi","roll $ROT_2b,%ecx"

        addl %esi,%edi                      #now edi = keystream
        xorl %edx,%edi                      #set up to compute edi = ciphertext below

        _o_ "addl %ebp,%eax","roll $ROT_3b,%edx","xorl %ebp,%edi"           #now edi = ciphertext
        _o_ "addl %esi,%ebx","roll $ROT_4b,%esi","movl X_i_1+4*_bb_+_SO_(%esp),%ebp"
        _o_ "xorl %eax,%ecx","roll $ROT_0a,%eax"
        _o_ "xorl %ebx,%edx","roll $ROT_1a,%ebx","addl _i_+_SO_(%esp),%ebp"
        _o_ "addl %ecx,%esi","roll $ROT_2a,%ecx","leal _bb_(%ebp,%edx),%ebp"

        _o_ "xorl %ebp,%eax","roll $ROT_3a,%edx","movl dstPtr+_SO_(%esp),%ebp"
        _o_ "xorl %esi,%ebx","roll $ROT_4a,%esi"
        _o_ "addl %eax,%ecx","roll $ROT_0b,%eax","movl %edi,4*_bb_(%ebp)"   #save ciphertext
        _o_ "addl %ebx,%edx","roll $ROT_1b,%ebx","movl exitTab+4*\_blkNum_+_SO_(%esp),%edi"
        _o_ "xorl %ecx,%esi","roll $ROT_2b,%ecx"
        
        PhelixEarlyExit edi,\_blkNum_       #do we need to do an early exit? If so, do it
       .endif
      .endr
        PhelixEndLoop   UNROLL_CNT          #set condition code for _until below
    _until b
        jmp *exitTab+4*(UNROLL_CNT-1)+_SO_(%esp)    #"return" to do more
##
##----------------------------------------------------------------
## Decryption routine
##----------------------------------------------------------------
##
        .align  4
C_global PhelixDecryptPacket,ECRYPT_AE_decrypt_packet
        PhelixAlgo  Decrypt             #instantiate the algorithm ocde
        ##
        ## the main block processing loop
        ##
    _rept
      .irp _blkNum_,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
       .if  \_blkNum_ < UNROLL_CNT
strCat  DecryptBlk_,\_blkNum_,":"       #make a label for re-entry points
        .set _bb_,\_blkNum_ & 7         #support UNROLL_CNT > 8 (but not really!)
        _o_ "addl %edx,%eax","roll $ROT_3b,%edx","movl X_i_0+4*_bb_+_SO_(%esp),%ebp"
        _o_ "addl %esi,%ebx","roll $ROT_4b,%esi"
        _o_ "xorl %eax,%ecx","roll $ROT_0a,%eax","movl srcPtr+_SO_(%esp),%edi"
        _o_ "xorl %ebx,%edx","roll $ROT_1a,%ebx","addl %edx,%ebp"
        _o_ "addl %ecx,%esi","roll $ROT_2a,%ecx"

        _o_ "xorl %ebp,%eax","roll $ROT_3a,%edx","movl 4*_bb_(%edi),%ebp"   #ebp = ciphertext
        _o_ "xorl %esi,%ebx","roll $ROT_4a,%esi","movl oldZ+4*(_bb_&3)+_SO_(%esp),%edi"
        _o_ "addl %eax,%ecx","roll $ROT_0b,%eax"
        _o_ "addl %ebx,%edx","roll $ROT_1b,%ebx"
        _o_ "xorl %ecx,%esi","roll $ROT_2b,%ecx"

        addl %esi,%edi                      #set edi = keystream
        xorl %ebp,%edi                      #now edi = plaintext
        movl %edx,%ebp
        xorl %edi,%ebp                      #now ebp = plaintext ^ edx

        _o_ "addl %ebp,%eax","roll $ROT_3b,%edx"
        _o_ "addl %esi,%ebx","roll $ROT_4b,%esi","movl X_i_1+4*_bb_+_SO_(%esp),%ebp"
        _o_ "xorl %eax,%ecx","roll $ROT_0a,%eax"
        _o_ "xorl %ebx,%edx","roll $ROT_1a,%ebx","addl _i_+_SO_(%esp),%ebp"
        _o_ "addl %ecx,%esi","roll $ROT_2a,%ecx","leal _bb_(%ebp,%edx),%ebp"

        _o_ "xorl %ebp,%eax","roll $ROT_3a,%edx","movl dstPtr+_SO_(%esp),%ebp"
        _o_ "xorl %esi,%ebx","roll $ROT_4a,%esi"
        _o_ "addl %eax,%ecx","roll $ROT_0b,%eax","movl %edi,4*_bb_(%ebp)"   #save plaintext computed above
        _o_ "addl %ebx,%edx","roll $ROT_1b,%ebx","movl exitTab+4*\_blkNum_+_SO_(%esp),%edi"
        _o_ "xorl %ecx,%esi","roll $ROT_2b,%ecx"

        PhelixEarlyExit edi,\_blkNum_       #do we need to do an early exit? If so, do it
       .endif
      .endr
        PhelixEndLoop   UNROLL_CNT          #set condition code for _until below
    _until b
        jmp     *exitTab+4*(UNROLL_CNT-1)+_SO_(%esp)    #"return" to do more
##
_PhelixCodeEnd_:

##
##----------------------------------------------------------------
## "Incremental" function: SetupNonce
##----------------------------------------------------------------
##  use same stack as EncryptPacket!
##
C_global PhelixSetupNonce,ECRYPT_AE_ivsetup
        pushal
        lea     callerParms-_Phelix_LocalSize(%esp),%esi
        subl    $_Phelix_LocalSize,%esp
_SO_            =   0
        call    InitNonce
        movl    $_ret_SetupNonceDone,exitTab+4*(ZERO_INIT_CNT-1)+_SO_(%esp)
        jmp     EncryptBlk_0
_ret_SetupNonceDone:
    .if UNROLL_CNT > ZERO_INIT_CNT      #do we need to clear out the return point?
        .err    "Replicate code here from _ret_InitZeroDone"
    .endif
        movl    ctxt_Ptr+_SO_(%esp),%ebp        #save our context
        #
        movl    $MAGIC_AAD_XOR,%edi
        xorl    %edi,%ebx
        movl    %edi,aadXor(%ebp)
        #
        movl    %eax,4*0+_Z_(%ebp)
        movl    %ebx,4*1+_Z_(%ebp)
        movl    %ecx,4*2+_Z_(%ebp)
        movl    %edx,4*3+_Z_(%ebp)
        movl    %esi,4*4+_Z_(%ebp)

        .irp    _nn_,0,1,2,3
          movl  X_i_1+8*\_nn_  +_SO_(%esp),%eax
          movl  X_i_1+8*\_nn_+4+_SO_(%esp),%ebx
          movl  oldZ +4*\_nn_  +_SO_(%esp),%ecx
          movl  %eax,X_1+  8*\_nn_(%ebp)
          movl  %ebx,X_1+4+8*\_nn_(%ebp)
          movl  %ecx,old_Z+4*\_nn_(%ebp)
        .endr
        #
        xorl    %edi,%edi
        movl    %edi,msgLen  (%ebp)
        movl    %edi,aadLen  (%ebp)
        movl    %edi,aadLen+4(%ebp)
        movl    _i_+_SO_(%esp),%edi
        movl    %edi,blkNum(%ebp)
        #
        addl    $_Phelix_LocalSize,%esp
        popal
        ret
##
##----------------------------------------------------------------
## "Incremental" function: EncryptBytes/DecryptBytes
##----------------------------------------------------------------
##  use same locals stack as EncryptPacket
##
_pOfs_  =       _cpOfs_
        _newParm 1,ctxt_Ptr
        _newParm 1,src_Ptr
        _newParm 1,dst_Ptr
        _newParm 1,bCnt
##
C_global PhelixEncryptBytes,ECRYPT_AE_encrypt_bytes
        pushal
        leal    Encrypt_jmpTab,%ebp
PhelixBytes:
        leal    callerParms-_Phelix_LocalSize(%esp),%esi
        subl    $_Phelix_LocalSize,%esp
    .set _SO_,0
        movl    %ebp,jmpTabPtr+_SO_(%esp)
        ## copy context to local on stack
        movl    ctxt_Ptr_LCL(%esi),%ebp
        _push   esi
        leal    X_0(%ebp),%esi
        leal    X_i_0+_SO_(%esp),%edi
        movl    $8+8+4,%ecx                 #X_0, X_1, and oldZ
        cld
        rep     movsl                       #copy the context
        xorl    %eax,%eax   
        movl    $UNROLL_CNT,%ecx            #zero out exitTab
        rep     stosl
        _pop    esi
        leal    _ret_PhelixBytes,%ebp
        movl    %ebp,retAddr_LCL(%esi)      #set up return address
        movl    src_Ptr_LCL(%esi),%ebp      #copy srcPtr and dstPtr
        movl    %ebp,srcPtr+_SO_(%esp)
        movl    dst_Ptr_LCL(%esi),%ebp
        movl    %ebp,dstPtr+_SO_(%esp)
        movl    ctxt_Ptr_LCL(%esi),%ebp
        movl    blkNum(%ebp),%edi           #convert blkNum from pCtxt to locals
        andl    $~(UNROLL_CNT-1),%edi
        movl    %edi,_i_+_SO_(%esp)
        movl    blkNum(%ebp),%edi
        shll    $2,%edi                     #convert blkNum to a word count
        movl    %edi,loopByteCnt+_SO_(%esp) #and save it as the "phase"
        movl    _Z_+4*0(%ebp),%eax          #load the Z values
        movl    _Z_+4*1(%ebp),%ebx
        movl    _Z_+4*2(%ebp),%ecx
        movl    _Z_+4*3(%ebp),%edx
        movl    _Z_+4*4(%ebp),%esi
        xorl    aadXor(%ebp),%ebx
        movl    $0,aadXor(%ebp)

        _push   esi
        leal    callerParms+_SO_(%esp),%esi
        movl    src_Ptr_LCL(%esi),%ebp
        movl    %ebp,srcPtr+_SO_(%esp)
        movl    bCnt_LCL(%esi),%ebp
        movl    dst_Ptr_LCL(%esi),%edi
        jmp     processUserData
        _pop    esi
_ret_PhelixBytes:

        ## copy modified value back to context
        movl    ctxt_Ptr+_SO_(%esp),%ebp
        movl    %eax,_Z_+4*0(%ebp)          #store the values Z0..Z4
        movl    %ebx,_Z_+4*1(%ebp)
        movl    %ecx,_Z_+4*2(%ebp)
        movl    %edx,_Z_+4*3(%ebp)
        movl    %esi,_Z_+4*4(%ebp)

        movl    msgLen0+_SO_(%esp),%edi     #update pCtxt.blkNum
        movl    %edi,%esi
        addl    $3,%edi
        shrl    $2,%edi
        addl    %edi,blkNum(%ebp)
        addl    %esi,msgLen(%ebp)           #track low 2 bits of msgLen

        leal    old_Z(%ebp),%edi
        leal    oldZ+_SO_(%esp),%esi
        movl    $4,%ecx                 #copy back the updated oldZ values
        rep     movsl

        addl    $_Phelix_LocalSize,%esp
        popal
        ret
        #
        ## handle decryption here
C_global PhelixDecryptBytes,ECRYPT_AE_decrypt_bytes
        pushal
        leal    Decrypt_jmpTab,%ebp
        jmp     PhelixBytes
##
##----------------------------------------------------------------
## "Incremental" function: Finalize (MAC)
##----------------------------------------------------------------
##  use same locals stack as EncryptPacket
##
_pOfs_  =       _cpOfs_
        _newParm    1,ctxt_Ptr
        _newParm    1,mac_Ptr
##
C_global PhelixFinalize,ECRYPT_AE_finalize
        pushal
        leal    callerParms-_Phelix_LocalSize(%esp),%esi
        subl    $_Phelix_LocalSize,%esp
    .set _SO_,0
        leal    Encrypt_jmpTab,%ebp
        movl    %ebp,jmpTabPtr+_SO_(%esp)

        ## copy context to local on stack
        movl    ctxt_Ptr_LCL(%esi),%ebp
        _push   esi
        leal    X_0(%ebp),%esi
        leal    X_i_0+_SO_(%esp),%edi
        movl    $8+8+4,%ecx                 #X_0, X_1, and oldZ
        cld 
        rep     movsl                       #copy the context
        xorl    %eax,%eax
        movl    $UNROLL_CNT,%ecx            #zero out exitTab
        rep     stosl
        _pop    esi

        movl    ctxt_Ptr_LCL(%esi),%ebp
        movl    blkNum(%ebp),%edi           #convert blkNum from pCtxt to locals
        andl    $~(UNROLL_CNT-1),%edi   
        movl    %edi,_i_+_SO_(%esp)

        movl    msgLen(%ebp),%eax
        subl    $4,%eax
        negl    %eax
        andl    $3,%eax                     #track the low 2 bits of msgLen
                
        movl    blkNum(%ebp),%edi
        shll    $2,%edi                     #convert blkNum to a word count
        subl    %eax,%edi
        movl    %edi,loopByteCnt+_SO_(%esp) #and save it as the "phase"

        movl    _Z_+4*0(%ebp),%eax          #load the Z values
        movl    _Z_+4*1(%ebp),%ebx
        movl    _Z_+4*2(%ebp),%ecx
        movl    _Z_+4*3(%ebp),%edx
        movl    _Z_+4*4(%ebp),%esi

        xorl    aadXor  (%ebp),%ebx
        xorl    aadLen  (%ebp),%esi
        xorl    aadLen+4(%ebp),%ecx
        movl    mac_Ptr+_SO_(%esp),%ebp
        jmp     processMAC
##
##
##----------------------------------------------------------------
## "Incremental" function: ProcessAAD
##----------------------------------------------------------------
 .set _Phelix_LocalSize,0
        _newLocal   1,aad_I                 #different local stack from from above!
        _newLocal   1,aad_bb
        _newLocal   1,aad_tmp
##
_cpOfs_ =       4+8*4+_Phelix_LocalSize     #caller parms offset from esp
_pOfs_  =       _cpOfs_
        _newParm    1,ctxt_Ptr
        _newParm    1,aad_Ptr
        _newParm    1,aad_Len
##
C_global PhelixProcessAAD,ECRYPT_AE_authenticate_bytes
        pushal
        subl    $_Phelix_LocalSize,%esp
    .set _SO_,0
        movl    ctxt_Ptr+_SO_(%esp),%ebp    #point to context
        movl     aad_Len+_SO_(%esp),%edi
        addl    %edi,aadLen  (%ebp)         #update accumulated length
        adcl    $0  ,aadLen+4(%ebp)
        movl    blkNum(%ebp),%edi
        movl    %edi,aad_I+_SO_(%esp)

        movl    _Z_+4*0(%ebp),%eax          #load the Z values
        movl    _Z_+4*1(%ebp),%ebx
        movl    _Z_+4*2(%ebp),%ecx
        movl    _Z_+4*3(%ebp),%edx
        movl    _Z_+4*4(%ebp),%esi

        subl    $4,aad_Len+_SO_(%esp)       #are we done yet?
        _rept ae
aad_Again:movl  aad_I+_SO_(%esp),%edi
          andl  $7,%edi
          movl  ctxt_Ptr+_SO_(%esp),%ebp
          _o_   "addl %edx,%eax","roll $ROT_3b,%edx","movl X_0(%ebp,%edi,4),%ebp"
          _o_   "addl %esi,%ebx","roll $ROT_4b,%esi","movl %edi,aad_bb+_SO_(%esp)"
          _o_   "xorl %eax,%ecx","roll $ROT_0a,%eax","movl aad_Ptr+_SO_(%esp),%edi"
          _o_   "xorl %ebx,%edx","roll $ROT_1a,%ebx","addl %edx,%ebp"       
          _o_   "addl %ecx,%esi","roll $ROT_2a,%ecx"

          _o_   "xorl %ebp,%eax","roll $ROT_3a,%edx","movl (%edi),%ebp"     #ebp = AAD plaintext
          _o_   "xorl %esi,%ebx","roll $ROT_4a,%esi","addl $4,%edi"
          _o_   "addl %eax,%ecx","roll $ROT_0b,%eax","movl %edi,aad_Ptr+_SO_(%esp)"
          _o_   "addl %ebx,%edx","roll $ROT_1b,%ebx","xorl %edx,%ebp"
          _o_   "xorl %ecx,%esi","roll $ROT_2b,%ecx","movl aad_bb+_SO_(%esp),%edi"

          _o_   "addl %ebp,%eax","roll $ROT_3b,%edx","movl ctxt_Ptr+_SO_(%esp),%ebp"
          _o_   "addl %esi,%ebx","roll $ROT_4b,%esi","movl X_1(%ebp,%edi,4),%ebp"
          _o_   "xorl %eax,%ecx","roll $ROT_0a,%eax"
          _o_   "xorl %ebx,%edx","roll $ROT_1a,%ebx","addl aad_I+_SO_(%esp),%ebp"
          _o_   "addl %ecx,%esi","roll $ROT_2a,%ecx","addl %edx,%ebp"

          _o_   "xorl %ebp,%eax","roll $ROT_3a,%edx","movl ctxt_Ptr+_SO_(%esp),%ebp"
          _o_   "xorl %esi,%ebx","roll $ROT_4a,%esi","andl $3,%edi"
          _o_   "addl %eax,%ecx","roll $ROT_0b,%eax","incl aad_I+_SO_(%esp)"
          _o_   "addl %ebx,%edx","roll $ROT_1b,%ebx"
          _o_   "xorl %ecx,%esi","roll $ROT_2b,%ecx","movl %esi,old_Z(%ebp,%edi,4)"
          subl  $4,aad_Len+_SO_(%esp)       #are we done yet?
        _until  b

        ## note ebp == ctxt_Ptr here
        movl    aad_Len+_SO_(%esp),%edi     #at this point, -4 <= aad_Len < 0
        andl    $3,%edi                     #any odd bytes left?
        _if z                               #if not, we are done
          movl  aad_I+_SO_(%esp),%edi       #copy back the updated blkNum 
          movl  %edi,blkNum(%ebp)

          movl  %eax,_Z_+4*0(%ebp)              #save the Z values
          movl  %ebx,_Z_+4*1(%ebp)    
          movl  %ecx,_Z_+4*2(%ebp)    
          movl  %edx,_Z_+4*3(%ebp)    
          movl  %esi,_Z_+4*4(%ebp)    

          ## clean up the stack and return
          addl  $_Phelix_LocalSize,%esp
          popal
          ret
        _endif
        ## here to handle odd AAD bytes
        movl    aad_Ptr+_SO_(%esp),%ebp     #get the final partial word
        movl    (%ebp),%ebp
        andl    MASK_TAB(,%edi,4),%ebp      #mask off unused bits
        leal    aad_tmp+_SO_(%esp),%edi
        movl    %edi,aad_Ptr+_SO_(%esp)     #point aad_Ptr to aad_Tmp
        movl    %ebp,(%edi)                 #store zero-padded word there
        xorl    %ebp,%ebp                   #fix up the count to not come here again
        movl    %ebp,aad_Len+_SO_(%esp)
        jmp     aad_Again
##
##----------------------------------------------------------------
## "Incremental" function: SetupKey
##----------------------------------------------------------------
##
    .set _Phelix_LocalSize,0
        _newLocal   1,sk_esi
        _newLocal   1,sk_Cnt
##
_cpOfs_ =       4+8*4+_Phelix_LocalSize #caller parms offset from esp
_pOfs_  =       _cpOfs_
        _newParm    1,ctxt_Ptr
        _newParm    1,key_Ptr
        _newParm    1,key_Size
        _newParm    1,iv_Size
        _newParm    1,mac_Size
##
C_global PhelixSetupKey,ECRYPT_AE_keysetup
        pushal
        subl    $_Phelix_LocalSize,%esp
    .set _SO_,0
        movl    ctxt_Ptr+_SO_(%esp),%ebp    #point to the context to be built
        movl    key_Size+_SO_(%esp),%eax    #copy keySize
        movl    %eax,keySize(%ebp)
        movl    mac_Size+_SO_(%esp),%ebx    #and macSize
        movl    %ebx,macSize(%ebp)
        andl    $127,%ebx                   #and compute X1_Bump
        shll    $8  ,%ebx
        shrl    $1  ,%eax                   #eax = keySize/2 (in bits)
        addl    %eax,%ebx
        movl    %ebx,X_1_Bump(%ebp)         #then store it
        shrl    $2  ,%eax                   #eax = keySize/8 (# bytes of key)

        ## now copy in the key bits
        movl    key_Ptr+_SO_(%esp),%edi
        xorl    %ebx,%ebx                   #ebx = counter
        _rept
          cmpl  %eax,%ebx                   #is this full word part of the key?
          _brk  ae                          #if not, go handle partial word (if any)
          movl  (%edi,%ebx),%ecx            #else get next full word of key
          movl  %ecx,X_0(%ebp,%ebx)         #and copy it to context
          addl  $4,%ebx                     #bump counter
        _endr                               #go back for more
        testl   $3,%eax                     #if any partial words, handle that here
        _if nz
          movl  %eax,%esi
          andl  $3,%esi                     #esi = (keySize/8) mod 4
          movl  MASK_TAB(,%esi,4),%ecx      #mask off "unused" bits
          andl  %ecx,X_0-4(%ebp,%ebx)
        _endif
        xorl    %ecx,%ecx                   #zero out the rest of the context key
        _rept
          cmpl  $8*4,%ebx                   #are we done yet?
          _brk  ae
          movl  %ecx,X_0(%ebp,%ebx)         #zero context key
          addl  $4,%ebx
        _endr
        ## now run the Feistel network for initial key mixing
        addl    $64,%eax
        movl    %eax,sk_esi+_SO_(%esp)      #precompute L(U)+64 "constant" for mixing
        movl    $128,sk_Cnt+_SO_(%esp)      #use this as a counter
        _rept
          movl  sk_Cnt+_SO_(%esp),%edi
          andl  $16,%edi                    #isolate one bit
          movl  X_0+4*0(%ebp,%edi),%eax 
          movl  X_0+4*1(%ebp,%edi),%ebx    
          movl  X_0+4*2(%ebp,%edi),%ecx    
          movl  X_0+4*3(%ebp,%edi),%edx    
          movl  sk_esi+ _SO_(%esp),%esi
          .rept 2                           #unroll just a bit
            _o_ "addl %edx,%eax","roll $ROT_3b,%edx"
            _o_ "addl %esi,%ebx","roll $ROT_4b,%esi"
            _o_ "xorl %eax,%ecx","roll $ROT_0a,%eax"
            _o_ "xorl %ebx,%edx","roll $ROT_1a,%ebx"
            _o_ "addl %ecx,%esi","roll $ROT_2a,%ecx"
      
            _o_ "xorl %edx,%eax","roll $ROT_3a,%edx"
            _o_ "xorl %esi,%ebx","roll $ROT_4a,%esi"
            _o_ "addl %eax,%ecx","roll $ROT_0b,%eax"
            _o_ "addl %ebx,%edx","roll $ROT_1b,%ebx"
            _o_ "xorl %ecx,%esi","roll $ROT_2b,%ecx"
          .endr
          xorl  $16,%edi                    #go to other half
          xorl  %eax,X_0+4*0(%ebp,%edi)     #perform the Feistel xor
          xorl  %ebx,X_0+4*1(%ebp,%edi)
          xorl  %ecx,X_0+4*2(%ebp,%edi)
          xorl  %edx,X_0+4*3(%ebp,%edi)
          subl  $16,sk_Cnt+_SO_(%esp)
        _until be
        ## clean up the stack and return
        addl    $_Phelix_LocalSize,%esp
        popal
        ret
##
##----------------------------------------------------------------
##
C_global PhelixIncremental_CodeSize
        mov     $(.- _PhelixCodeStart_),%eax
        ret
##
##
##----------------------------------------------------------------
## use this NOP routine to calibrate/check our timing tests
##----------------------------------------------------------------
##
C_global PhelixNop
        pushal
        popal
        ret
##
##----------------------------------------------------------------
## size statistics at compile time
##----------------------------------------------------------------
##
C_global PhelixProcessPacket_CodeSize,ECRYPT_AE_process_packet_CodeSize
        movl    $(_PhelixCodeEnd_-_PhelixCodeStart_),%eax
        ret
##
    .end
