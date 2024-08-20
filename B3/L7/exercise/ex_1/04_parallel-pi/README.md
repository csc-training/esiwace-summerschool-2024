
# Parallel calculation of pi

Using the template, parallelize the numerical estimation of Pi to work with any number of MPI processes.
The code should integrate over a function representing the first quarter of the unit circle, thus evaluating
to pi/4. The numerical integration is performed over `n` steps (840 in the template) along the x-axis. 
Divide the integration range among processes to provide partial sums. Afterwards, use `MPI_Send` and `MPI_Recv`
to get the final result on rank 0.


