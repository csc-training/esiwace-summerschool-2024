program hello
  implicit none

  print *, 'Now I master!'
  !$omp parallel
  print *, 'X'
  !$omp end parallel

end program hello
