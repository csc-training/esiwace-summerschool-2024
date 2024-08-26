PROGRAM hello_world_mpi
include 'mpif.h'

integer my_rank, no_of_ranks, ierror

call MPI_INIT(ierror)
call MPI_COMM_SIZE(MPI_COMM_WORLD, no_of_ranks, ierror)
call MPI_COMM_RANK(MPI_COMM_WORLD, my_rank, ierror)

print *, 'Hello World from process: ', my_rank, 'of ', no_of_ranks

call MPI_FINALIZE(ierror)
END PROGRAM
