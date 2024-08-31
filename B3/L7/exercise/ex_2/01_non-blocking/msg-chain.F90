program chain
  use mpi
  use iso_fortran_env, only : REAL64

  implicit none
  integer, parameter :: msgsize = 10000000
  integer :: err, myid, ntasks
  integer :: message(msgsize)
  integer :: receiveBuffer(msgsize)
  integer :: status(MPI_STATUS_SIZE,2)

  real(REAL64) :: t0, t1

  integer :: source, destination
  integer :: count
  integer :: requests(2)

  call mpi_init(err)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, err)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, err)

  message = myid

  ! Set source and destination ranks
  if (myid < ntasks-1) then
     destination = myid + 1
  else
     destination = MPI_PROC_NULL
  end if
  if (myid > 0) then
     source = myid - 1
  else
     source = MPI_PROC_NULL
  end if

  ! Start measuring the time spent in communication
  call mpi_barrier(mpi_comm_world, err)
  t0 = mpi_wtime()

  ! TODO: Implement the message passing using non-blocking
  !       sends and receives


  ! TODO: Add here a synchronization call so that you can be sure
  !       that the message has been received

  ! Use status parameter to find out the no. of elements received
  call mpi_get_count(status(:,1), MPI_INTEGER, count, err)
  write(*,'(A10,I3,A20,I8,A,I3,A,I3)') 'Sender: ', myid, &
       ' Sent elements: ', msgsize, &
       '. Tag: ', myid + 1, &
       '. Receiver: ', destination
  write(*,'(A10,I3,A20,I8,A,I3,A,I3)') 'Receiver: ', myid, &
       'received elements: ', count, &
       ' First element: ', receiveBuffer(1)

  ! Finalize measuring the time and print it out
  t1 = mpi_wtime()
  call mpi_barrier(mpi_comm_world, err)

  call print_ordered(t1 - t0)

  call mpi_finalize(err)

contains

  subroutine print_ordered(t)
    implicit none
    real(REAL64) :: t

    integer i

    if (myid == 0) then
       write(*, '(A20, I3, A, F6.3)') 'Time elapsed in rank', myid, ':', t
       do i=1, ntasks-1
           call mpi_recv(t, 1, MPI_DOUBLE_PRECISION, i, 11,  &
                         MPI_COMM_WORLD, MPI_STATUS_IGNORE, err)
           write(*, '(A20, I3, A, F6.3)') 'Time elapsed in rank', i, ':', t
       end do
    else
       call mpi_send(t, 1, MPI_DOUBLE_PRECISION, 0, 11,  &
                         MPI_COMM_WORLD, err)
    end if
  end subroutine print_ordered



end program chain
