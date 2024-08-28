# Simple tasking

Explore tasking and data sharing with tasks

Starting from the skeleton code (tasks.F90), add an OpenMP parallel region 
to the code, and start **tasks**. Each loop iteration should be executed by 
one task. Each loop iteration prints out the thread ID performing it and saves
it to an `array`. At the end, the contents of `array` should be identical with the
printouts from the tasks. 

Play around with different data sharing clauses (both for the parallel
region and for the tasks), and investigate how they affect the results.
What kind of clauses are needed for obtaining the results described above?
