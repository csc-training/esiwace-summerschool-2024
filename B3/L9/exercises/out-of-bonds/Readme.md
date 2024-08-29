# Memory checking

Compile and run a simple OpenACC test program with bug which make is access out of bounds elements, provided as `out_of_bounds.f90`.

In order to compile the program on Levante, you'll need to first load the
following module:
```bash
module load nvhpc/24.5-gcc-13.3.0
```

After this, you can compile the program using the NVHPC compiler (`nvc` or
`nvfortran`):
```bash
nvfortran -Minfo=all -acc=gpu,verystrict -gpu=cc80 -o out_of_bounds out_of_bounds.f90
```

An example batch job script (`job.sh`) is provided and can be used to run the
program.

Run first the code normally and inspect the output. Change the size of the array and check the result.  Next modify use the nvidia tool `compute-sanitizer`, to catch the errors and get more information. Modify the batch script by adding `/sw/spack-levante/nvhpc-24.5-ipi3ad/Linux_x86_64/24.5/compilers/bin/compute-sanitizer` just before of the executable. Inspect the output.
