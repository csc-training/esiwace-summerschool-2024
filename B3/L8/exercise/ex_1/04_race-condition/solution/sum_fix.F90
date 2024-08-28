program vectorsum
  use iso_fortran_env, only: int64
  implicit none
  integer(int64), parameter :: nx = 102400

  integer(int64), dimension(nx) :: vecA
  integer(int64) :: psum, sumex
  integer(int64) :: i

  ! Initialization of vector
  do i = 1, nx
     vecA(i) = i
  end do

  sumex = nx*(nx+1)/2
  write(*,*) 'Arithmetic sum formula (exact):                  ', sumex

  psum = 0
  ! Sum with data race
  !$omp parallel do default(shared) private(i) reduction(+:psum)
  do i = 1, nx
     psum = psum + vecA(i)
  end do
  !$omp end parallel do
  write(*,*) 'Sum with fixed omp:                              ', psum

end program vectorsum
