COMP=nvhpc

ifeq ($(COMP),nvhpc)
CC=nvc
FC=nvfortran
CCFLAGS=-g -acc -O3 -target=gpu -gpu=cc80
FCFLAGS=-g -acc -O3 -target=gpu -gpu=cc80
# FCFLAGS=-g -Mbounds
RUN=
endif

EXE=heat
OBJS=pngwriter.o heat.o main.o

all: $(EXE)

# Dependencies
main.o: pngwriter.o heat.o main.F90
heat.o: heat.F90

$(EXE): $(OBJS) .ALWAYSEXEC
	$(FC) $(FCFLAGS) $(OBJS) -o $@ -lpng

pngwriter.o: pngwriter.c
	$(CC) $(CCFLAGS) -c $< -o $@

%.o: %.F90
	$(FC) $(FCFLAGS) -c $< -o $@

clean:
	-/bin/rm -f $(EXE)
	-/bin/rm -f  *.o *.mod *~ *.png

.ALWAYSEXEC:
