## Hybrid Hello World

Write a simple hybrid MPI+OpenMP program.

Launch OpenMP threads within each MPI task and make each thread print out
both the MPI rank and the thread ID. Investigate also the thread support level
of the underlying MPI implementation. 

For the Slurm allocation combine the specifications for processes and threads, 
e.g. `--ntasks=4 --cpus-per-task=4` reserves a total of 16 cores.
