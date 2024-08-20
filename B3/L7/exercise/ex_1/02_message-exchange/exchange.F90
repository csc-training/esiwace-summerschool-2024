program exchange
  use mpi
  implicit none
  integer, parameter :: arraysize = 100000, msgsize = 100
  integer :: err, myid, ntasks, nrecv
  integer :: status
  integer :: message(arraysize)
  integer :: receiveBuffer(arraysize)

  call mpi_init(err)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, err)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, err)

  message = myid
  receiveBuffer = -1

  ! TODO: Implement sending and receiving as defined in the assignment
  ! Send msgsize elements from the array "message", and receive into
  ! "receiveBuffer"
  if (myid == 0) then

     call mpi_get_count(status, MPI_INTEGER, nrecv, err)
     write(*,'(A10,I3,A10,I6, A17, I3)') 'Rank: ', myid, &
          ' received ', nrecv, ' elements, first ', receiveBuffer(1)
  else if (myid == 1) then

     call mpi_get_count(status, MPI_INTEGER, nrecv, err)
     write(*,'(A10,I3,A10,I6, A17, I3)') 'Rank: ', myid, &
          ' received ', nrecv, ' elements, first ', receiveBuffer(1)
  end if

  call mpi_finalize(err)

end program exchange
