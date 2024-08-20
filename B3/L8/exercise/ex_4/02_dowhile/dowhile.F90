
program dowhile
use omp_lib
use iso_fortran_env, only : REAL64
implicit none
 
 logical :: cond
 integer :: i
 real(REAL64) :: t0,t1

 cond=.true.
 i = 0

 t0 = omp_get_wtime()

 ! TODO: Insert the required OMP clauses to parallelize the "work" done in the 
 !       do while loop using OMP tasks.

 do while (cond)
    call work(i)
    i = i + 1
    cond = check_some_condition(i) 
 end do

 ! TODO: end

 t1 = omp_get_wtime()

 write(*,*) "Time spent ", t1-t0


 CONTAINS

 subroutine work(ii)
    integer,intent(in) :: ii
    integer :: j = 10000
    integer :: k,z
    ! Simulate some heavy work
    k = 0
    do z = 1,j
        k = k + 1
    end do
    write(*,*) "iteration: ",ii
 end subroutine work

 logical function check_some_condition(ii)
    integer, intent(in) :: ii
    check_some_condition = ( ii < 100 )
 end function check_some_condition



end program dowhile
