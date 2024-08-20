## Message chain

Write a program where every MPI task sends data to the next one.
Let `ntasks` be the number of processes, and `myid` the rank of the
current process. 

1. Using the template *chain.F90*, write a program as follows:

- Every process with a rank smaller than `ntasks-1` sends a message to process
  `myid+1`. For example, process 0 sends a message to process 1.
- The message content is an integer array where each element is initialised to
  `myid`.
- The message tag is the receiver's rank.
- The sender prints out the number of elements it sends and the tag it used.
- All except the first process (with rank > 0) receive messages (hint: `MPI_PROC_NULL` 
  can be used for this).
- Each receiver prints out their `myid` and the first element in the
  received array.

The code prints out the time spent in communication.
Investigate the timings with different numbers of MPI tasks
(e.g. 2, 4, 8, 16, ...), and pay attention especially to rank 0.
Can you explain the behaviour?


2. Use combined `MPI_Sendrecv` instead of individual `MPI_Send`s or
   `MPI_Recv`s. Investigate again the timings with different numbers of MPI tasks
   (e.g. 2, 4, 8, 16, ...). Compare the results to the implementation with individual
   `MPI_Send`s or `MPI_Recv`s and pay attention especially to rank 0.
   Can you explain the behaviour? 


3. Take the code from part 1 and modify it further to create a full circular 
   communication pattern, i.e. the destination of the message sent by the
   rank `ntasks-1` should be 0 instead of `MPI_PROC_NULL`. The outcome is 
   similar to the problem arising in the previous exercise (make sure you
   understand the reason for this). How would you resolve the issue?


