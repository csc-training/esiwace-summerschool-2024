## Race condition in parallel sum

the template code sums up all the elements of a vector A, initialized as A=1,2,...,N in a serial execution. 
For reference, from the arithmetic sum formula we know that the result should be S=N(N+1)/2.

Parallelise the summation loop by adding OpenMP directives similar to previous exercise. Obviously there is a problem as hinted by the topic of the 
exercice. Test and see how the program behaves and make sure to understand why. How could you fix the code? Run the code 
multiple times and with different number of threads, e.g. 10 or more -- with low threadcount you may get the right answer even with 
a race condition present just by luck. 



