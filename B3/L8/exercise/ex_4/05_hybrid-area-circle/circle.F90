
program circle
use mpi
use iso_fortran_env, only : REAL64
implicit none

 real(REAL64) :: t0,t1

 ! Circle size, center point etc.
 real(REAL64), parameter :: radius = 2.
 real(REAL64), parameter :: c_x = 0., c_y = 0.  
 real(REAL64), parameter :: pi = 3.14159265359
 integer, parameter :: nxg = 10000, nyg = 10000  ! global "grid" points

 real(REAL64) :: xaxis(nxg), yaxis(nyg) ! Grid axis
 real(REAL64) :: dx,dy                  ! Resolution

 real(REAL64) :: area_sub, area_tot     ! Estimated subdomain area, total area
 real(REAL64) :: exact                  ! Exact solution

 integer :: myid, pes, nx_per_pe        ! mpi rank, number of processes, number of columns per process
 integer :: nxi,nxf                     ! Subdomain column limits
 integer :: i, j, err

 integer :: provided, required=MPI_THREAD_FUNNELED

 call MPI_Init_thread(required,provided,err)

 ! Timer
 call MPI_Barrier(MPI_COMM_WORLD,err)
 t0 = MPI_Wtime()

 ! Set up axes and other shared things
 call initialize() 

 ! Exact solution
 exact = pi*radius**2

 call MPI_Comm_size(MPI_COMM_WORLD,pes,err)
 call MPI_Comm_rank(MPI_COMM_WORLD,myid,err)

 ! TODO: define column limits per mpi process

 ! TODO: Use openmp to parallelize the estimation of the subdomain area per mpi process
 !       and finally calculate the total area of the circle
 area_sub = 0.
 do j = 1,nyg
    do i = nxi,nxf
        if ( SQRT((xaxis(i)-c_x)**2 + (yaxis(j)-c_y)**2) < radius ) then
            area_sub = area_sub + (dx*dy)
        end if
    end do
 end do

 ! Timer
 call MPI_Barrier(MPI_COMM_WORLD,err)
 t1 = MPI_Wtime() 

 if (myid == 0) then 
    write(*,*) 'Exact ', exact
    write(*,*) 'Estimated ',area_tot
    write(*,*) 'Time spent ', t1-t0
 end if

 call MPI_Finalize(err)

 contains

 subroutine initialize()
    dx = 2.*radius/nxg
    dy = 2.*radius/nyg
    xaxis=0.
    yaxis=0.
    do i = 1,nxg
        xaxis(i) = (c_x-radius) + (i-1)*dx
    end do
    do j = 1,nyg
        yaxis(j) = (c_y-radius) + (j-1)*dy
    end do
 end subroutine initialize


end program circle
