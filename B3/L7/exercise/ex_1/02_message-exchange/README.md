## Message exchange

Write a program where two processes send and receive a message to/from
each other using `MPI_Send` and `MPI_Recv`.

Start with the template code exchange.f90 as a starting point. The *message* 
content is initialized as the rank of each process. Place the appropriate
calls to `MPI_Send` followed by `MPI_Recv` within the *if-else* statements so 
that the sent *message* is received in *receiveBuffer*. These should be followed by 
printing out the first element of the received array. 

1. First use the provided *msgSize* as the number of elements sent.

2. Increase *msgSize* to the full array size of 100000, recompile and run. What happens? What if 
you reorder the send and receive calls in one of the processes? Why?

