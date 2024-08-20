program vectorsum
  use iso_fortran_env, only: int64
  implicit none
  integer(int64), parameter :: nx = 102400

  integer(int64), dimension(nx) :: vecA ! data
  integer(int64) :: psum, sumex         ! parallel sum, exact sum
  integer(int64) :: i

  ! Initialization of vector
  do i = 1, nx
     vecA(i) = i
  end do

  sumex = nx*(nx+1)/2
  write(*,*) 'Arithmetic sum formula (exact):                  ', sumex

  psum = 0
  ! TODO: Parallelize the computation
  do i = 1, nx
     psum = psum + vecA(i)
  end do
  write(*,*) 'Sum: ', psum
end program vectorsum
