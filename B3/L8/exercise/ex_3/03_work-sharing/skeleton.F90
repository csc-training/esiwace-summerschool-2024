program vector_addition
  use iso_fortran_env, only : real64
  use omp_lib
  implicit none
  integer, parameter :: nx = 102400

  real, dimension(nx) :: vecA, vecB, vecC
  integer :: i
  real(real64) :: stime,ftime

  ! Initialization of vectors
  do i = 1, nx
     vecA(i) = 1.0/(real(nx - i + 1))
     vecB(i) = vecA(i)**2
  end do

  stime = omp_get_wtime()
  ! TODO:
  !   Implement here the parallelized version of vector addition,
  !   vecC = vecA + vecB

  ftime = omp_get_wtime()

  ! Compute the check value
  write(*,*) 'Reduction sum: ', sum(vecC)
  write(*,*) 'Execution time: ',ftime-stime

end program vector_addition
