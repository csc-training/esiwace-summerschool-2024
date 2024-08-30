# Exercises

## Introduction to accelerators & OpenACC

In this session we do the following exercises

- [Exercise 1, hello world](hello-world/)
- [Exercise 2, vector sum](vector-sum/)
- [Exercise 3, double loop](doubleloop/)

## OpenACC data management

In this session we do the following exercises

- [Exercise 4, jacobi](jacobi/)
- [Exercise 5, heat](heat/) (BONUS)

## Profiling and performance optimization

In this session we do the following exercises

- Analyze performance of exercise jacobi or heat. Use  the [jacobi solution](jacobi/solution) or the  [heat solution](heat/solution) if you did not finish it on your own in the last session.
- In order to perform the analysis we can the `nsys` tool. In the command line we execute the program via `nsys`using: 

```
nsys profile -t nvtx,cuda -o results --stats=true --force-overwrite true ./a.out
```   
## Debugging
- [Exercise 6, memory checking](out-of-bonds/)

## Interoperability (BONUS) 
- [Exercise 7, calling cuda library from openacc](curand-interoperability/)
