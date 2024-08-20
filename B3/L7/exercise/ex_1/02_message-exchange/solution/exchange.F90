program exchange
  use mpi
  implicit none
  integer, parameter :: arraysize = 100000, msgsize = 100000
  integer :: err, myid, ntasks, nrecv
  integer :: status(MPI_STATUS_SIZE)
  integer :: message(arraysize)
  integer :: receiveBuffer(arraysize)

  call mpi_init(err)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, err)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, err)

  message = myid
  receiveBuffer = -1

  ! Send and receive as defined in the assignment
  if (myid == 0) then
     call mpi_send(message, msgsize, MPI_INTEGER, 1, &
          1, MPI_COMM_WORLD, err)
     call mpi_recv(receiveBuffer, arraysize, MPI_INTEGER, 1,  &
          2, MPI_COMM_WORLD, status, err)
     call mpi_get_count(status, MPI_INTEGER, nrecv, err)
     write(*,'(A10,I3,A10,I6, A17, I3)') 'Rank: ', myid, &
          ' received ', nrecv, ' elements, first ', receiveBuffer(1)
  else if (myid == 1) then
     call mpi_recv(receiveBuffer, arraysize, MPI_INTEGER, 0,  &
          1, MPI_COMM_WORLD, status, err)
     call mpi_send(message, msgsize, MPI_INTEGER, 0, &
          2, MPI_COMM_WORLD, err)
  call mpi_get_count(status, MPI_INTEGER, nrecv, err)
     write(*,'(A10,I3,A10,I6, A17, I3)') 'Rank: ', myid, &
          ' received ', nrecv, ' elements, first ', receiveBuffer(1)
  end if

  call mpi_finalize(err)

end program exchange
