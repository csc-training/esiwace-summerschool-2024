# Jacobi iteration: OpenACC data directives

Use OpenACC to implement a Jacobi iteration code that does the computation
entirely on the GPU device.

Starting from a serial code that implements a Jacobi iteration (provided in
file `jacobi.F90`, modify the code is such a way that the computation is
done entirely on the device without any additional data transfers taking place
between the host and the device.
As bonus compare the execution time in which no explicit data management is done, i.e. similarly to the [double loop](../doubleloop/solution/ftn
/doubleloop.F90) exercise.
