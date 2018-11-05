program solver

use iso_c_binding, only : c_float, c_int

implicit none

interface
    real(c_float) function cspeed(polls) BIND(C)
        use iso_c_binding, only : c_float, c_int
        integer(c_int) :: polls
    end function cspeed
end interface

real (c_float) :: clockSpeed
integer (c_int) :: polls

clockSpeed = cspeed(1)
write(0, *) "CPU Speed:", clockSpeed



end program solver
