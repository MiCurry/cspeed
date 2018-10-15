all: cspeed test

FLAGS =

test: cspeed
	gfortran $(FLAGS) -o test testing.f90 cspeed.o rdtscp.o rtc_timer.o

cspeed: cspeed.f90 rdtscp.c rtc_timer.c
	gfortran $(FLAGS) -c rdtscp.c
	gfortran $(FLAGS) -c rtc_timer.c
	gfortran $(FLAGS) -c cspeed.f90

clean:
	rm -f *.o *.mod test
