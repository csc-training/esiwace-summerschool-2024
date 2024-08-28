program hello
use omp_lib
  implicit none

  integer :: rank, threads

  print *, 'Now I master!'
  !$omp parallel private(rank)
  rank = omp_get_thread_num()
  threads = omp_get_num_threads()
  print *, 'This is thread ',rank, ' from a team of ',threads,' threads'
  !$omp end parallel

end program hello
