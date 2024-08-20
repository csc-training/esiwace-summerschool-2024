
# Hybrid parallel calculation of the area of a circle

The template code defines a very brute force method to estimate the area of a circle by looping through a 2-dimensional grid. 
Parallelize the code using a hybrid MPI-OpenMP approach: Let each MPI process have a number of columns while using OpenMP 
threads for parallel looping of the grid points within each process. Finally combine the results for the full area of the circle.
Try with different numbers of processes and threads and see how this affects the execution time. You can also try to change the number
of grid points.


