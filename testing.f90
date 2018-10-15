program solver

use cspeed

implicit none

real :: cpuSpeed

cpuSpeed = speed()

write(0, *) "CPU Speed:", cpuSpeed

end program solver
