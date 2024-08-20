program hello
  use mpi
  implicit none
  integer :: err, myid, ntasks

  call mpi_init(err)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, err)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, err)

  if(myid == 0) then
     write(*,*) 'In total there are ', ntasks, 'tasks'
  endif

  write(*,*) 'Hello from rank ', myid

  call mpi_finalize(err)

end program hello
