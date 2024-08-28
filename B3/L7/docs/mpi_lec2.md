---
title:  Parallel programming with MPI, part II
event:  ESiWACE3-WarmWorld Summer School on HPC for Climate and Weather Applications
lang:   en
---

# Contents for parts I & II

- Two lectures + two exercise sessions; examples and exercises in Fortran

- The basic premise for parallel computing and the key programming models

- Distributed memory computing and the Message Passing Interface (MPI): why is it needed

- How to exchange information between processes
    - Part I: simple communication between specific processes/CPUs
    - Part II: Continue on process-to-process communication + collective communication (simultaneously across a range of processes)


# Learning objectives, part II

- Understand the non-blocking communication concept

- Understand the collective communication concept

- Know how to implement basic parallel arithmetics using the collective functions

# Non-blocking point-to-point communication {.section}


# Non-blocking communication

- Functions return immediately &rarr; continue program execution with concurrent operations
- Must check explicitly the communication has completed by the time the data is needed
    - Blocking: **`MPI_Wait`**,**`MPI_Waitall`**
    - Non-blocking **`MPI_Test`** &larr; require periodical testing


# Non-blocking Send {.split-definition}

- Same parameters as with regular **`MPI_Send`** plus **`request`**

MPI_ISend(`buf`{.input}, `count`{.input}, `datatype`{.input}, `dest`{.input}, `tag`{.input}, `comm`{.input}, `request`{.output}, `err`{.output})
  : type(\*) `buf(..)`{.input}
    : Send buffer that must not be written to until one has checked
      that the operation is over
  : integer `request`{.output}
    : A handle used to check if communication has finished


# Non-blocking Recv {.split-definition}

- Same as with regular **`MPI_Recv`** plus **`request`**, without **`status`**

MPI_IRecv(`buf`{.output}, `count`{.input}, `datatype`{.input}, `source`{.input}, `tag`{.input}, `comm`{.input}, `request`{.output}, `err`{.output})
  : type(\*) `buf(..)`{.output}
    : Receive buffer guaranteed to contain the data only after one has
      checked that the operation is over
  : integer `request`{.output}
    : A handle used to check if communication has finished


# Finalizing non-blocking communication {.split-definition}

MPI_Wait(`request`{.input}, `status`{.output}, `err`{.output})
  : type(MPI_Request) `request`{.input}
    : Handle of the non-blocking communication
  : integer `status(MPI_STATUS_SIZE)`{.output}
    : Status of the completed communication, same as in **`MPI_Recv`**

MPI_Waitall(`count`{.input}, `requests`{.input}, `status`{.output}, `err`{.output})
  : integer `count`{.input}
    : Number of requests
  : integer `requests(count)`{.input}
    : Array of requests
  : integer `status(MPI_STATUS_SIZE,*)`{.output}
    : Array of statuses



# Finalizing non-blocking communication {.split-definition}

MPI_Test(`request`{.input}, `flag`{.output}, `status`{.output}, `err`{.output})
  : integer `request`{.input}
    : Request
  : logical `flag`{.output}
    : True if the operation has completed
  : integer `status(MPI_STATUS_SIZE)`{.output}
    : Status for the completed operation

<br>

- A call to **`MPI_Test`** is non-blocking. It allows one to schedule alternative activities while periodically checking for completion.


# Collective communication {.section}

# Collective communication

- Transmit data among all the processes in a communicator
    - Easier to implement and understand, and often more efficient that building same functionality with point-to-point communications

- **Must** be called by all processes, i.e. no rank based branching

- Various types
    - Data  distribution
    - Collective computation -- reduction operations
    - Synchronization



# **``MPI_Bcast``**

- Send a buffer from a root process to all other processes

![](img/bcast.svg){.center width=40%}


# **``MPI_Bcast``** {.split-definition}

MPI_Bcast(`buf`{.input}`fer`{.output}, `count`{.input}, `datatype`{.input}, `root`{.input}, `comm`{.input}, `err`{.output})
  : type(\*) `buf`{.input}`fer(..)`{.output}
    : Data to be broadcasted / received

  : integer `count`{.input}
    : Number of elements in buffer

  : integer `datatype`{.input}
    : Type of elements in buffer

  : integer `root`{.input}
    : The rank of sending process

  : integer `comm`{.input}
    : Communicator




# **``MPI_Scatter``** {.split-definition}

- Spread data evenly from a root process to all other processes

![](img/scatter.svg){.center width=60%}


# **``MPI_Scatter``** {.split-definition}

MPI_Scatter(`sendbuf`{.input}, `sendcount`{.input}, `sendtype`{.input}, `recvbuf`{.output}, `recvcount`{.input}, `recvtype`{.input}, `root`{.input}, `comm`{.input}, `err`{.output})
  : type(\*) `sendbuf(..)`{.input}
    : Data to be scattered

  : integer `sendcount`{.input}
    : Number of elements to send to each process

  : integer `sendtype`{.input}
    : Type of elements in send buffer

  : type(\*) `recvbuf(..)`{.output}
    : Buffer for receiving data

  : integer `recvcount`{.input}
    : Number of elements to receive

  : integer `recvtype`{.input}
    : Type of elements to receive

  : integer `root`{.input}
    : The rank of sending process

  : integer `comm`{.input}
    : Communicator


# **``MPI_Scatter``** example {.split-definition}


<div class=column>

- For 4 MPI processes


```fortran
IF (rank==0) THEN
    DO i = 1, 16
        a(i) = i
    END DO
END IF
CALL MPI_Scatter(a, 4, MPI_INTEGER, aloc, 4 &
              MPI_INTEGER, 0, MPI_COMM_WORLD, &
              err)
IF (rank==2) WRITE(*,*) aloc(:)
```

</div>

<div class=column>

What would be the result?

</div>


# **``MPI_Scatter``** example {.split-definition}


<div class=column>

- For 4 MPI processes


```fortran
IF (rank==0) THEN
    DO i = 1, 16
        a(i) = i
    END DO
END IF
CALL MPI_Scatter(a, 4, MPI_INTEGER, aloc, 4 &
              MPI_INTEGER, 0, MPI_COMM_WORLD, &
              err)
IF (rank==2) WRITE(*,*) aloc(:)
```

</div>

<div class=column>

What would be the result?
```bash
9 10 11 12
```

</div>


# **``MPI_Scatter``** example {.split-definition}


<div class=column>

- For 4 MPI processes


```fortran
IF (rank==0) THEN
    DO i = 1, 16
        a(i) = i
    END DO
END IF
CALL MPI_Scatter(a, 4, MPI_INTEGER, aloc, 4 &
              MPI_INTEGER, 0, MPI_COMM_WORLD, &
              err)
IF (rank==2) WRITE(*,*) aloc(:)
```

</div>

<div class=column>

What would be the result?
```bash
9 10 11 12
```
&rarr; Rank 0 consecutively sends blocks of 4 elements from an array of length 16 to other ranks, i.e. rank 0 gets numbers 1-4,
rank 1 gets 5-8 etc. 


<div>




# **``MPI_Gather``** {.split-definition}

- Collect data from other processes to a root - "inverse" scatter

![](img/gather.svg){.center width=55%}



# **``MPI_Gather``** {.split-definition}

MPI_Gather(`sendbuf`{.input}, `sendcount`{.input}, `sendtype`{.input}, `recvbuf`{.output},`recvcount`{.input}, `recvtype`{.input}, `root`{.input}, `comm`{.input}, `err`{.output})
  : type(\*) `sendbuf(..)`{.input}
    : Data to be gathered

  : integer `sendcount`{.input}
    : Number of elements sent by each process

  : integer `sendtype`{.input}
    : Type of elements sent

  : type(\*) `recvbuf(..)`{.output}
    : Buffer for receiving data

  : integer `recvcount`{.input}
    : Number of elements to receive

  : integer `recvtype`{.input}
    : Type of elements to receive

  : integer `root`{.input}
    : The rank of receiving process

  : integer `comm`{.input}
    : Communicator


# **``MPI_Reduce``** {.split-definition}


- Apply a reduction operation across processes and place the result in a specified root process

MPI_Reduce(`sendbuf`{.input}, `recvbuf`{.output}, `count`{.input}, `datatype`{.input}, `op`{.input}, `root`{.input}, `comm`{.input}, `err`{.output})
  : type(\*) `sendbuf(..)`{.input}
    : Data to be reduced

  : type(\*) `recvbuf(..)`{.output}
    : Buffer for receiving data

  : integer `count`{.input}
    : Number of elements in send buffer

  : integer `datatype`{.input}
    : Type of elements in send buffer

  : integer `op`{.input}
    : Applied operation

  : integer `root`{.input}
    : The rank of receiving process

  : integer `comm`{.input}
    : Communicator

# **``MPI_Reduce``** {.split-definition}

- Several different operations available


<div class=column>
| Operation    | Meaning              |
|--------------|----------------------|
| `MPI_MAX`    | Max value            |
| `MPI_MIN`    | Min value            |
| `MPI_SUM`    | Sum                  |
| `MPI_PROD`   | Product              |
| `MPI_MAXLOC` | Max value + location |
| `MPI_MINLOC` | Min value + location |
</div>
<div class=column>
| Operation  | Meaning      |
|------------|--------------|
| `MPI_LAND` | Logical AND  |
| `MPI_BAND` | Bitwise AND  |
| `MPI_LOR`  | Logical OR   |
| `MPI_BOR`  | Bitwise OR   |
| `MPI_LXOR` | Logical XOR  |
| `MPI_BXOR` | Bitwise XOR  |
</div>




# Example: parallel dot product {.split-definition}


<div class=column>
```fortran
REAL :: a(1024), aloc(128), r, rloc
...
IF (rank==0) THEN
    CALL random_number(a)
END IF
CALL MPI_Scatter(a, 128, MPI_INTEGER, &
                 aloc, 128, MPI_INTEGER, &
                 0, MPI_COMM_WORLD, err)
rloc = SUM(aloc(:)**2)
CALL MPI_Reduce(rloc, r, 1, MPI_REAL, &
                MPI_SUM, 0, MPI_COMM_WORLD, &
                err)
WRITE(*,*) "id=", rank, " local="rloc
IF (rank==0) WRITE(*,*) "global=",r


```
</div>
<div class=column>

- An array of random numbers is generated and distributed evenly across processes
- Each process calculates the dot product of their portion of the array with itself, i.e. $r_{loc} = a_{loc}(1)^2 + a_{loc}(2)^2 + ...$
- MPI reduction operator is used to sum up the final result across processes


</div>


# Example: parallel dot product {.split-definition}


<div class=column>
```fortran
REAL :: a(1024), aloc(128), r, rloc
...
IF (rank==0) THEN
    CALL random_number(a)
END IF
CALL MPI_Scatter(a, 128, MPI_INTEGER, &
                 aloc, 128, MPI_INTEGER, &
                 0, MPI_COMM_WORLD, err)
rloc = SUM(aloc(:)**2)
CALL MPI_Reduce(rloc, r, 1, MPI_REAL, &
                MPI_SUM, 0, MPI_COMM_WORLD, &
                err)
WRITE(*,*) "id=", rank, " local="rloc
IF (rank==0) WRITE(*,*) "global=",r


```
</div>
<div class=column>
```bash
> srun -n 8 ./mpi_pdot
 id= 6 local= 39.68326
 id= 7 local= 39.34439
 id= 1 local= 42.86630
 id= 3 local= 44.16300
 id= 5 local= 39.76367
 id= 0 local= 42.85532
 id= 2 local= 40.67361
 id= 4 local= 49.45086
 global= 338.8004
```


</div>



# **``MPI_Alltoall``** {.split-definition}

- Spread data from each process to all processes
- Resembles a transpose operation

![](img/alltoall.svg){.center width=65%}



# **``MPI_Alltoall``** {.split-definition}


MPI_Alltoall(`sendbuf`{.input}, `sendcount`{.input}, `sendtype`{.input}, `recvbuf`{.output},`recvcount`{.input},`recvtype`{.input}, `comm`{.input}, `err`{.output})
  : type(\*) `sendbuf(..)`{.input}
    : Data to be sent

  : integer `sendcount`{.input}
    : Number of elements to send by each process

  : integer `sendtype`{.input}
    : Type of elements to send

  : type(\*) `recvbuf(..)`{.output}
    : Buffer for receiving data

  : integer `recvcount`{.input}
    : Number of elements to receive from each process

  : integer `recvtype`{.input}
    : Type of elements to receive

  : integer `comm`{.input}
    : Communicator



# Further reading

- The collective communication functions presented are blocking - non-blocking counterparts exist
- Many also have other alternative/"extended" versions, e.g.
    - **``MPI_Allreduce``**, **``MPI_Allgather``** -- post the result to all processes
    - **``MPI_Scatterv``**, **``MPI_Gatherv``** -- scatter/gather with variable **`sendcount`{.input}** across processes


# Summary

- Non-blocking send/receive provide potential performance gains or may help resolving deadlocks

    - Programmer must ensure successful data transfer

- Collective communication offers a more efficient data exchange between several processes

- Collective reduction operations enable straightforward arithmetics across multiple processes


# Exercise 2

- `git clone https://github.com/csc-training/esiwace-summerschool-2024`  <br>
  (or update existing `git pull origin main`)

- Lunch ~12:00

- Take breaks :)

- References:
    - https://rookiehpc.org/mpi/docs/index.html
    - https://docs.open-mpi.org/en/v5.0.x/man-openmpi/index.html
    - https://www.mpich.org/static/docs/latest/




















