program out_of_bounds
  implicit none
  integer           :: i, n = 1000
  real              :: s
  real, allocatable :: a(:)
  allocate (a(n))
!$acc data create(a) copyout(s)
!$acc parallel loop
  do i = 1, n
     a(i) = i
  end do
!$acc end parallel loop

!$acc parallel loop
  do i = 1, n
     a(i) = 2*a(i)
  end do
!$acc end parallel loop

  s = 0.
!$acc parallel loop reduction(+:s)
  do i = 1, n
  ! out-of-bounds access
     s = s + a(i+800)
  end do
!$acc end parallel loop
!$acc end data
  print *, s
end program
