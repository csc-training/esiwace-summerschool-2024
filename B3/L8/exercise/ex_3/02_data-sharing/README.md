## Data sharing and parallel regions

Explore data sharing between OpenMP threads. In the previous exercise we already
used `private` to have a unique value for rank in each thread.

Starting from the skeleton code, add an OpenMP parallel region around the
block where the variables `Var1` and `Var2` are printed and manipulated.

What results do you get when you define the variables as **shared**,
**private** or **firstprivate**? Explain why do you get different results.
Note that in some cases the compiler may also put out some warnings.
