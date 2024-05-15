module vars

   !==============================================================!
   !      Este módulo lee y guarda los parámetros de entrada.     !
   !==============================================================!

   ! Definimos un módulo que lea información y la comparta de forma global.
   implicit none

   ! Declaramos los arreglos que usaremos.
   real(8), allocatable, dimension (:) :: t, Th1, Th2, Xi1, Xi2

   ! Declaramos las variables que pediremos.
   integer selector
   integer Nt, Nx
   integer puntosT, savedataT
   real(8) tf, dt, dx
   real(8) alpha, beta, w
   real(8) theta1Inicial, theta2Inicial

   ! Declaramos variables del método.
   real(8) k1Th1, k1Th2, k1Xi1, k1Xi2
   real(8) k2Th1, k2Th2, k2Xi1, k2Xi2
   real(8) k3Th1, k3Th2, k3Xi1, k3Xi2
   real(8) k4Th1, k4Th2, k4Xi1, k4Xi2

   ! Declaramos variables que guarden a las funciones derivadas.
   real(8) dTh1, dTh2, dXi1, dXi2

   ! Declaramos constantes útiles.
   real(8) cero, sexto, cuarto, medio, uno, dos, pi

contains

   !---------------------------------------------------------------
   ! Definimos una subrutina que solicite variables de entrada.
   subroutine lector

      ! Definimos un entero para referirnos al 'input.par'.
      integer fid

      ! Abrimos el 'input.par'.
      open(newunit = fid, file = './input.par', action = 'read', position = 'rewind')

      !---------------------------------------------------------------
      ! Comenzamos a solicitar la información.

      ! Valor de selector, indica qué tipo de solución queremos.
      read(fid,*) selector

      ! Valor de dt, el tamaño de paso temporal.
      read(fid,*) dt

      ! Valor de tf, el tiempo final de integración.
      read(fid,*) tf

      ! Cuántos puntos temporales tendrá el archivo de datos.
      read(fid,*) puntosT

      ! Valor de Nx, cuántos puntos tendrá la malla del fractal.
      read(fid,*) Nx

      ! Condición inicial para \theta_1
      read(fid,*) theta1Inicial

      ! Condición inicial para \theta_2
      read(fid,*) theta2Inicial

      ! Valor de alpha.
      read(fid,*) alpha

      ! Valor de beta.
      read(fid,*) beta

      ! Valor de w.
      read(fid,*) w

      !---------------------------------------------------------------
      ! Definimos las constantes útiles.
      cero   = 0.0D0
      sexto  = 1.0D0/6.0D0
      cuarto = 1.0D0/4.0D0
      medio  = 1.0D0/2.0D0
      uno    = 1.0D0
      dos    = 2.0D0
      pi     = 4.0D0*atan(1.0D0)

      ! Definimos los pasos temporales y el tamaño de paso espacial.
      Nt = int( tf/dt )
      savedataT = int( Nt/puntosT )
      dx = (dos*pi)/Nx

      !---------------------------------------------------------------
      ! Cerramos las puertas que abrimos.
      close(fid)

   end subroutine lector

end module vars
