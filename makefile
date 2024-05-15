FLAGS = -O2 -ffree-form -w 

OBJS = main.o vars.o rk4.o derivadas.o calibrador.o fractal.o

build : dir link

dir :
	@ mkdir -p data

link : $(OBJS)
	@ echo 'Compilando (...)'
	@ gfortran $(FLAGS) -o pendulito $(OBJS)
	@ echo 'Limpiando archivos extra (...)'
	@ rm *.o
	@ echo 'Moviendo el ejecutable a la carpeta 'data' (...)'
	@ mv pendulito data
	@ echo 'Copiando el graficador a la carpeta 'data' (...)'
	@ cp jitmap.py data
	@ echo 'Copiando los parámetros de entrada a la carpeta 'data' (...)'
	@ cp input.par data
	@ echo 'Todo está listo para ejecutar UwUr'

clean :
	@ echo 'Limpiando el espacio de trabajo (...)'
	@ rm -r data
	@ echo 'Todo quedó como antes de compilar UwUr'

main.o : main.f90
	@ gfortran $(FLAGS) -c main.f90

vars.o : vars.f90
	@ gfortran $(FLAGS) -c vars.f90

rk4.o : rk4.f90
	@ gfortran $(FLAGS) -c rk4.f90

derivadas.o : derivadas.f90
	@ gfortran $(FLAGS) -c derivadas.f90

calibrador.o : calibrador.f90
	@ gfortran $(FLAGS) -c calibrador.f90

fractal.o : fractal.f90
	@ gfortran $(FLAGS) -c fractal.f90
