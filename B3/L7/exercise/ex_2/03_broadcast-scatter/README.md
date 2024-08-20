
# Broadcast and scatter

Write a program using point-to-point send and receive calls to implement **broadcast** and **scatter**
operations. This exercise illustrates that while in principle about any type of communication
pattern can be implemented using just `MPI_Send`s and `MPI_Recv`s, this quickly escalates into 
a lot of work, where the collective collective functions may provide a much more efficient solution.
It also shows how to communicate a part of an array instead of a whole array of data using point-to-point operations.

1. Create an integer array of size N (e.g. N=12) and initialize it as follows:
   - rank 0: i (i=1,12)
   - other ranks: -1
2. Print out the initial values in all the processes
3. Implement **broadcast**: rank 0 sends the contents of the entire array to other ranks.
   Print out the final values in all the processes.
4. Implement **scatter**: imagine that the array is divided into blocks of size N / P (P=number of
   processes), and rank 0 sends a different block to other ranks, so that the rank *i* receives
   the *i*th block. Print out the final values in all the processes.


You may start from scratch or use the template code as a starting point.

