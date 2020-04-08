/*
 * main.c  -- start point for bsc
 * (c) Thomas Pornin 1998
 */

#define MAJ_VERSION	0
#define MIN_VERSION	1

#include "lexer.h"
#include "syntax.h"
#include "dump.h"
#include "opt.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void print_version(void)
{
	fprintf(stderr, "bsc -- the bitslice compiler, "
		"(c) Thomas Pornin 1998, version %d.%d\n",
		(int)MAJ_VERSION, (int)MIN_VERSION);
	exit(0);
}

void print_usage(char *name)
{
	fprintf(stderr, "usage: %s [ -v ] [ -h ] [ -p funname ]"
		" [ -o outfile ] [ file ]\n", name);
	exit(1);
}

int main(int argc, char *argv[])
{
	FILE *f, *g;
	char *infile = 0, *outfile = 0, *fun = 0;
	struct action *al;
	struct symbol *inout[2];
	int i;

	for (i = 1; i < argc; i ++) {
		if (!strncmp(argv[i], "-v", 2)) print_version();
		else if (!strncmp(argv[i], "-h", 2)) print_usage(argv[0]);
		else if (!strncmp(argv[i], "-p", 2)) {
			if (fun != 0 || i == (argc - 1))
				print_usage(argv[0]);
			i ++;
			fun = argv[i];
		}
		else if (!strncmp(argv[i], "-o", 2)) {
			if (outfile != 0 || i == (argc - 1))
				print_usage(argv[0]);
			i ++;
			outfile = argv[i];
		} else if (*(argv[i]) == '-') {
			fprintf(stderr, "unknown option %s\n", argv[i]);
			print_usage(argv[0]);
		} else {
			if (infile != 0) print_usage(argv[0]);
			infile = argv[i];
		}
	}
	if (fun == 0) fun = "bsc_code";
	if (infile == 0 || !strcmp(infile, "-")) f = stdin;
	else {
		f = fopen(infile, "r");
		if (f == 0) {
			fprintf(stderr, "bsc: could not open file %s\n",
				infile);
			exit(1);
		}
	}
	if (outfile == 0 || !strcmp(outfile, "-")) g = stdout;
	else {
		g = fopen(outfile, "w");
		if (g == 0) {
			fprintf(stderr, "bsc: could not open file %s\n",
				outfile);
			exit(1);
		}
	}
	al = parse(f, inout);
	fclose(f);
	zap_redudancy(al, inout[0]->u.reg, inout[0]->width[0],
		inout[1]->u.reg, inout[1]->width[0]);
	dump_C(g, fun, al, inout[0]->u.reg, inout[0]->width[0],
		inout[1]->u.reg, inout[1]->width[0]);
	fclose(g);
	return 0;
}
