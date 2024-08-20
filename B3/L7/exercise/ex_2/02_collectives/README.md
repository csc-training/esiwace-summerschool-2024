## Collective operations

In this exercise we test different routines for collective communication.

Write a program to be run on four MPI processes. Each process will have a 
data vector with rank dependent values as initialized in the `skeleton.F90`
code used as the tarting point:
rank 0: 0,1,2,3,4,5,6,7
rank 1: 8,9,10,11,12,13,14,15 
etc.

In addition, each task has a receive buffer for eight (`2*n_mpi_tasks`) elements 
and the values in the buffer are initialized to -1.

Implement communication that sends and receives values from the data
vectors to the receive buffers using a single collective routine in
each case. 

The expected output and some tips for each case

### `MPI_Bcast`

Task 0:  0  1  2  3  4  5  6  7
Task 1:  8  9 10 11 12 13 14 15
Task 2: 16 17 18 19 20 21 22 23
Task 3: 24 25 26 27 28 29 30 31

Task 0:  0  1  2  3  4  5  6  7
Task 1:  0  1  2  3  4  5  6  7
Task 2:  0  1  2  3  4  5  6  7
Task 3:  0  1  2  3  4  5  6  7

Try changing the `root` parameter in the `MPI_Bcast` call.

### ``MPI_Gather

Consider the dimensions when setting the count parameters so that the 
`recvbuf` in the designated `root` is fully filled.

Task 0:  0  1  2  3  4  5  6  7
Task 1:  8  9 10 11 12 13 14 15
Task 2: 16 17 18 19 20 21 22 23
Task 3: 24 25 26 27 28 29 30 31

Task 0:  0  1  8  9 16 17 24 25
Task 1: -1 -1 -1 -1 -1 -1 -1 -1
Task 2: -1 -1 -1 -1 -1 -1 -1 -1
Task 3: -1 -1 -1 -1 -1 -1 -1 -1

### `MPI_Scatter`

Again consider the counts for even distribution of values. Try different numbers to map the behaviour. 
The example solution gives 

Task 0:  0  1  2  3  4  5  6  7
Task 1:  8  9 10 11 12 13 14 15
Task 2: 16 17 18 19 20 21 22 23
Task 3: 24 25 26 27 28 29 30 31

Task 0:  0  1 -1 -1 -1 -1 -1 -1
Task 1:  2  3 -1 -1 -1 -1 -1 -1
Task 2:  4  5 -1 -1 -1 -1 -1 -1
Task 3:  6  7 -1 -1 -1 -1 -1 -1

### `MPI_Alltoall`

Task 0:  0  1  2  3  4  5  6  7
Task 1:  8  9 10 11 12 13 14 15
Task 2: 16 17 18 19 20 21 22 23
Task 3: 24 25 26 27 28 29 30 31

Task 0:  0  1  8  9 16 17 24 25
Task 1:  2  3 10 11 18 19 26 27
Task 2:  4  5 12 13 20 21 28 29
Task 3:  6  7 14 15 22 23 30 31


