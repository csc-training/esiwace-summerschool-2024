#!/bin/sh

module purge
ml intel-oneapi-compilers/2023.2.1-gcc-11.2.0
ml intel-oneapi-mpi/2021.5.0-intel-2021.5.0

export I_MPI_PMI=pmi
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
