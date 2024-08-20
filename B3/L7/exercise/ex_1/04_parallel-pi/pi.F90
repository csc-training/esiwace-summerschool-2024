program parallel_pi
  use mpi
  use iso_fortran_env, only : REAL64
  implicit none

  integer, parameter :: dp = REAL64

  integer, parameter :: n = 840
  integer :: myid, ntasks, rc

  integer :: status(MPI_STATUS_SIZE)

  integer :: i 
  integer :: istart, istop, chunksize ! Start and stop indices for each process + size of the partial range
  real(dp) :: pi, localpi, x

  call mpi_init(rc)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, rc)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, rc)

  if (myid == 0) then
     write(*,*) "Computing approximation to pi with n=", n
     write(*,*) "Using", ntasks, "mpi processes"
  end if

  ! TODO determine the process-specific integration range.

  localpi = 0.0
  do i = istart, istop
     x = (i - 0.5) / n
     localpi = localpi + SQRT(1. - x**2)/n  
  end do

  ! TODO transmit the partial results to process 0 for a final result

    
  if (myid == 0) then
     write(*,'(A,F18.16,A,F10.8,A)') 'Approximate pi=', pi, ' (exact pi=', 4.0*atan(1.0_dp), ')'
  end if

  call mpi_finalize(rc)

end program

