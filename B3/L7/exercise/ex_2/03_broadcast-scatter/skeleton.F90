program bcast_scatter
  use mpi
  implicit none

  integer, parameter :: size=12
  integer :: ntasks, myid, err, i
  integer, dimension(size) :: sendbuf, recvbuf
  integer, dimension(size**2) :: printbuf
  integer :: status(MPI_STATUS_SIZE)

  call mpi_init(err)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, err)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, err)

  ! Initialize buffers
  call init_buffers

  ! Print data that will be sent
  call print_buffers(sendbuf)

  ! Send everywhere
  ! TODO for broadcast: Implement the broadcast of the array sendbuf using send and recv functions
  ! TODO for scatter: Implement the scatter of the array sendbuf using send and recv functions

  ! Print data that was received
  call print_buffers(recvbuf)

  call mpi_finalize(err)

contains

  subroutine init_buffers
    implicit none
    integer :: i
    if(myid==0) then
      do i = 1, size
         recvbuf(i) = -1
         sendbuf(i) = i
      end do
    else
     do i=1, size
         recvbuf(i) = -1
         sendbuf(i) = -1
     enddo
    endif
  end subroutine init_buffers


  subroutine print_buffers(buffer)
    implicit none
    integer, dimension(:), intent(in) :: buffer
    integer, parameter :: bufsize = size
    integer :: i
    character(len=40) :: pformat

    write(pformat,'(A,I3,A)') '(A4,I2,":",', bufsize, 'I3)'

    call mpi_gather(buffer, bufsize, MPI_INTEGER, &
         & printbuf, bufsize, MPI_INTEGER, &
         & 0, MPI_COMM_WORLD, err)

    if (myid == 0) then
       do i = 1, ntasks
          write(*,pformat) 'Task', i - 1, printbuf((i-1)*bufsize+1:i*bufsize)
       end do
       print *
    end if
  end subroutine print_buffers

end program
