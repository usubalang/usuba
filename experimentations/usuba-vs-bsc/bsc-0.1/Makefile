#
# Makefile for bsc
# (c) Thomas Pornin 1998
#

# ===================================================================
# Chose your compiler and other variables here
# ===================================================================

# Use here your favorite ansi C compiler and flags (-DDEBUG will build
#  a very verbose debug version)
CC = gcc
CFLAGS = -Wall -O2 # -DDEBUG

# Here add the flags and libraries needed for linking (hopefully none)
LDFLAGS =
LIBS =

# You need yacc or a compatible program (such as gnu bison) in order to
#  compile bsc
YACC = bison

# ===================================================================
# Nothing should be changed below this line
# ===================================================================

SRC = mem.c lexer.c main.c hash.c syntax.c parse.tab.c lut.c dump.c opt.c
OBJ = mem.o lexer.o main.o hash.o syntax.o parse.tab.o lut.o dump.o opt.o
HDR = mem.h lexer.h hash.h syntax.h parse.tab.h lut.h dump.h opt.h

all: bsc

clean:
	rm -f $(OBJ) parse.tab.c parse.tab.h core bsc

bsc: $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o bsc $(OBJ) $(LIBS)

parse.tab.c parse.tab.h: parse.y
	$(YACC) -b parse -d parse.y

$(OBJ): $(HDR)
