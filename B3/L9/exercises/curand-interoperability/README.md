# Calling cuRAND from OpenACC code

In this exercise we use routines from the cuRAND CUDA library to calculate a simple estimate for π. The skeleton code `curand_openacc.F90` implements a version that computes the estimate using cpu code. Fill in the missing parts of a function `gpu_pi` that does the similar computation using OpenACC.

Initializing and closing the random number generator is done in Fortran with a call
```Fortran
type(curandGenerator) :: g
logical :: istat
istat = curandCreateGenerator(g, CURAND_RNG_PSEUDO_DEFAULT)
...
istat = curandDestroyGenerator(g)
```

Vector `x` of `n` Uniform random numbers between 0 and 1 can be generated in Fortran using call

```Fortran
istat = curandGenerateUniform(g, x, n)
```

Here the vector `x` has to be a *device pointer*, so use correct `host_data` specification.
In order to avoid memory leak, the resources used by the random number generator have to be freed:
```Fortran
istat = curandDestroyGenerator(g)
```

**Note!** In order to compile the code you need to link to the `curand` library by adding the extra options:  
```
-L/sw/spack-levante/nvhpc-22.5-v4oky3/Linux_x86_64/22.5/cuda/11.0/lib64/ -lcurand
``` 
