## Hello World with MPI


The purpose of this exercise is to write a bare-bones mpi program and get used to
compiling and running your code on HPC (in this case the Levante). This will also
be the basis for bulding and running most of the subsequent exercises.

1. Write a parallel program that prints out something (e.g. "Hello
   world!") from multiple processes. Remember to call appropriate 
   initialisation and finalisation routines. 

   On Levante, make sure to have the correct module environment loaded. To check the 
   loaded modules, say
   ` >> module list`
   You should have the modules `intel-oneapi-compilers/2023.2.1-gcc-11.2.0` and 
   `intel-oneapi-mpi/2021.5.0-intel-2021.5.0` loaded for this exercise (and the 
   subsequent exercises in the MPI/OpenMP part of the course). Missing modules can be 
   loaded with
    >> module load `intel-oneapi-compilers/2023.2.1-gcc-11.2.0` 
    >> module load `intel-oneapi-mpi/2021.5.0-intel-2021.5.0`
   Running the `env_levante.sh` found in the scripts folder by `source env_levante.sh`
   will load the necessary modules and set some environment variables for you. 
   
   Use the MPI wrapper to compile your code, which will take care of all the linking
   and other necessary settings. The call to the wrapper is different for different environments,
   but for the intel compiler and MPI library it is `mpiifort`

   Run the code for example with 4 processors. Remember to perform your runs on compute nodes 
   instead of the login nodes. This can be done in several ways using the workload manager 
   installed in the HPC (Slurm in case of Levante): Suggested ones are i) make a job allocation 
   (`allocate_job.sh` provided) and use *srun* directly or ii) create a job script (`batch_job.sh` provided) 
   and submit the job using *sbatch batch_job.sh*. For small test codes, like most of the exercises, 
   i) is recommended.    

2. Modify the "Hellow world"-program so that each process prints out also its rank and so
   that the process with rank 0 prints out the total number of MPI processes
   as well.

