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
  !$omp parallel do default(shared) private(i)
  do i = 1, nx
     vecC(i) = vecA(i) + vecB(i)
  end do
  !$omp end parallel do
  ftime = omp_get_wtime()

  ! Compute the check value
  write(*,*) 'Reduction sum: ', sum(vecC)
  write(*,*) 'Execution time: ',ftime-stime

end program vector_addition
