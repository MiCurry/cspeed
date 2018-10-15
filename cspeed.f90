module cspeed
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! Module: cspeed - cpu speed
!
! Calculates the speed of the cpu.
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    use iso_c_binding, only : c_long
    use iso_c_binding, only : c_int

    private 
    public :: speed


    interface
        subroutine rdtscp(i) bind(C)
           use iso_c_binding, only : c_long
           integer (c_long), intent(out) :: i
        end subroutine rdtscp
    end interface

    integer (c_long) :: tsc_start, tsc_end, tsc_elapsed
     
    interface
        subroutine timer_start(timer_id) bind(C)
           use iso_c_binding, only : c_int
           integer (c_int), intent(in), value :: timer_id
        end subroutine timer_start

        subroutine timer_stop(timer_id, sec, nsec) bind(C)
           use iso_c_binding, only : c_int
           integer (c_int), intent(in), value :: timer_id
           integer (c_int), intent(out) :: sec, nsec
        end subroutine timer_stop
    end interface

    integer (c_int) :: timer_id, sec, nsec 

    interface
      !  should be unsigned int ... not available in Fortran
      !  OK until highest bit gets set.
      function FortSleep (seconds)  bind ( C, name="sleep" )
          import
          integer (c_int) :: FortSleep
          integer (c_int), intent (in), VALUE :: seconds
      end function FortSleep
    end interface


    contains

    function speed()
        implicit none
         
        integer(c_int) :: seconds
        real :: speed

        seconds = 2
        timer_id = 20

        call rdtscp(tsc_start)
        call timer_start(timer_id)
        seconds = FortSleep(seconds)
        call timer_stop(timer_id, sec, nsec)
        call rdtscp(tsc_end)
        tsc_elapsed = tsc_end - tsc_start

        sec = sec + nsec * 10e-9
        speed = real(tsc_elapsed) / real(sec)

    end function speed

end module cspeed
