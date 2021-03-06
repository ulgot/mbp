CC = nvcc
CFLAGS =-arch=sm_13 -m64 --use_fast_math -O3
CURAND =-L/usr/local/cuda/lib64 -lcurand
GCC = gcc
GCCFLAGS = -O3 -funroll-all-loops -fomit-frame-pointer -ffast-math
GSLLINK = -L/usr/lib/ -lgsl -lgslcblas
ICC = icc
ICCFLAGS = -fp-model fast=1

all: prog cpu cputests 

prog: prog.cu
	$(CC) $(CFLAGS) -o prog prog.cu $(CURAND) -lm

cpu: cpu_gsl.c
	$(GCC) $(GCCFLAGS) -o cpu cpu_gsl.c $(GSLLINK) -lm

cputests: cputests.c
	$(GCC) $(GCCFLAGS) -o cputests cputests.c $(GSLLINK) -lm

icpu: cpu_gsl.c
	$(ICC) $(ICCFLAGS) -o icpu cpu_gsl.c $(GSLLINL) -lm

icputests: cputests.c
	$(ICC) $(ICCFLAGS) -o icputests cputests.c $(GSLLINK) -lm

.PHONY: clean mrproper

clean: 
	if test -e cpu ; then rm cpu ; fi
	if test -e icpu ; then rm icpu ; fi
	if test -e cputests ; then rm cputests ; fi
	if test -e icputests ; then rm icputests ; fi
	if test -d tests ; then rm -rf tests; fi
