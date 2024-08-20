program chain
  use mpi
  use iso_fortran_env, only : REAL64

  implicit none
  integer, parameter :: size = 10000000
  integer :: err, myid, ntasks
  integer :: message(size)
  integer :: receiveBuffer(size)
  integer :: status(MPI_STATUS_SIZE)

  real(REAL64) :: t0, t1

  integer :: source, destination

  call mpi_init(err)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, err)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, err)

  message = myid
  receiveBuffer = -1

  ! Set source and destination ranks
  if (myid < ntasks-1) then
     destination = myid + 1
  else
     destination = 0  ! Note this lead to deadlock with the original communication pattern!
  end if
  if (myid > 0) then
     source = myid - 1
  else
     source = ntasks-1
  end if

  ! Start measuring the time spent in communication
  call mpi_barrier(mpi_comm_world, err)
  t0 = mpi_wtime()

  if (myid < ntasks-1) then  ! Changing the order of the calls for the final task resolves the deadlock!
    ! Send messages
    call mpi_send(message, size, MPI_INTEGER, destination, &
              myid+1, MPI_COMM_WORLD, err)
    write(*,'(A10,I3,A20,I8,A,I3,A,I3)') 'Sender: ', myid, &
              ' Sent elements: ', size, &
              '. Tag: ', myid+1, '. Receiver: ', destination

    ! Receive messages
    call mpi_recv(receiveBuffer, size, MPI_INTEGER, source,  &
              source+1, MPI_COMM_WORLD, MPI_STATUS_IGNORE, err)
    write(*,'(A10,I3,A,I3)') 'Receiver: ', myid, &
            ' First element: ', receiveBuffer(1)

  else

    ! Receive messages
    call mpi_recv(receiveBuffer, size, MPI_INTEGER, source,  &
              source+1, MPI_COMM_WORLD, MPI_STATUS_IGNORE, err)
    write(*,'(A10,I3,A,I3)') 'Receiver: ', myid, &
            ' First element: ', receiveBuffer(1)


    ! Send messages
    call mpi_send(message, size, MPI_INTEGER, destination, &
              myid+1, MPI_COMM_WORLD, err)
    write(*,'(A10,I3,A20,I8,A,I3,A,I3)') 'Sender: ', myid, &
              ' Sent elements: ', size, &
              '. Tag: ', myid+1, '. Receiver: ', destination

  end if


  ! Finalize measuring the time and print it out
  t1 = mpi_wtime()
  call mpi_barrier(mpi_comm_world, err)

  call print_ordered(t1 - t0)

  call mpi_finalize(err)

contains

  subroutine print_ordered(t)
    real(REAL64), INTENT(in) :: t

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
