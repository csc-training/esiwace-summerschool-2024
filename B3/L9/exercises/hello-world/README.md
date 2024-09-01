# Hello world with OpenACC

Compile and run a simple OpenACC test program, provided as `hello.F90`.

In order to compile the program on Levante, you'll need to first load the
following module:
```bash
module load nvhpc/24.5-gcc-13.3.0
```

After this, you can compile the program using the NVHPC compiler (`nvfortran`):
```bash
nvfortran -Minfo=all -acc=gpu,verystrict -gpu=cc80 -o hello hello.F90
```

An example batch job script (`job.sh`) is provided and can be used to run the
program. Modify the number of GPUs, by setting the batch option `--gpus` to something bigger. 

**Note** You can compile the code with `gfortran` or with `nvfortran` without `-acc` flag. What will you get in this case?
**Note**  Check what happens if you use `-acc=multicore,verystrict` instead of `-acc=gpu,verystrict -gpu=cc80`. 
