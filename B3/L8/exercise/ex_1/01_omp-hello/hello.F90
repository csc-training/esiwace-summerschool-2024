program hello
  implicit none

  integer :: rank, threads

  print *, 'Now I master!'
  !$omp parallel
  print *, 'X'
  !$omp end parallel

end program hello
