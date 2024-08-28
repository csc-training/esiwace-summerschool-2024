## Hello world

Similar to the very first MPI exercise, the purpose here is to compile 
and run a barebones OpenMP multithreaded program

1. Take the template code as it is and compile it by adding the OpenMP flag,
   i.e. `ifort -qopenmp`. To run on Levante, make the appropriate 
   Slurm allocation with the provided scripts: you will need to use
   the `salloc` command with the keyword `cpus-per-task`. For example,
   `--ntasks=1 --cpus-per-task=4` will reserve one process with 4 threads. 
   Remember to also set the environment variable `OMP_NUM_THREADS` to the number 
   of threads for the run. On Levante, execute the code using srun. 
   Try to run with different number of threads and see if the output has a 
   matching number of Xs. In this case the fastest way to do this is to reserve
   for example 16 threads in the Slurm allocation and change the `OMP_NUM_THREADS` 
   to any desired value up to 16.

2. Modify the code to use the `omp_lib` library and use the functions
   `omp_get_thread_num` and `omp_get_num_threads` to print out the
   rank of each threads and the total number of threads used.


