all: cspeed test

FLAGS = -g

test: cspeed
	gfortran $(FLAGS) -o test testing.f90 cspeed.o 

test_f: testing.f90 cspeed.o rdtscp.o rtc_timer.o
	gfortran $(FLAGS) -o test testing.f90 cspeed.o rdtscp.o rtc_timer.o

cspeed: cspeed.c testing.f90
	gfortran $(FLAGS) -c cspeed.c

cspeed_f: cspeed.f90 rdtscp.c rtc_timer.c
	gfortran $(FLAGS) -c rdtscp.c
	gfortran $(FLAGS) -c rtc_timer.c
	gfortran $(FLAGS) -c cspeed.f90

clean:
	rm -f *.o *.mod test
