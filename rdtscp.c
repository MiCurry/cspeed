#include <time.h>
#include <stdlib.h>
#include <stdio.h>

/* In Fortran, use the following as an interface for rdtscp:
    use iso_c_binding, only : c_long
 
    interface
        subroutine rdtscp(i) bind(C)
           use iso_c_binding, only : c_long
           integer (c_long), intent(out) :: i
        end subroutine rdtscp
    end interface
 
    integer (c_long) :: tsc_start, tsc_end 
*/

void rdtscp( long *i )
{
	unsigned rax, rdx;
	asm volatile ("RDTSCP\n\t"
			"mov %%edx, %0\n\t"
			"mov %%eax, %1\n\t": "=r" (rdx), "=r" (rax));
	*i = ((unsigned long)rdx << 32) + rax;
}
