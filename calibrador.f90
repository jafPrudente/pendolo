subroutine calibrador

   !=====================================================================!
   ! Esta subrutina soluciona solo una vez el sistema del péndulo doble. !
   !=====================================================================!

   !===============================================================
   ! Usamos el módulo 'vars' para tener información de los parámetros de entrada.
   use vars

   ! Por precaución no dejamos ningún tipo implícito.
   implicit none

   ! Declaramos variables útiles.
   integer i
   real(8) a, b ! Serán las amplitudes de la aproximación a ángulos pequeños.
   real(8) analitiks1, analitiks2 ! Serán la aproximación misma a ángulos pequeños para \theta1 y \theta2.

   !===============================================================
   ! Definimos las condiciones iniciales.
   Th1(1) = theta1Inicial
   Th2(1) = theta2Inicial
   Xi1(1) = cero
   Xi2(1) = cero
   t(1) = cero

   ! Definimos las amplitudes de las aproximaciones analíticas.
   a = +sqrt(dos)*theta1Inicial + theta2Inicial
   b = -sqrt(dos)*theta1Inicial + theta2Inicial

   !===============================================================
   ! Abrimos un archivo para guardar los datos, accedemos a él con la etiqueta '10'.
   open(10, file = 'sol.csv', status = 'replace')

   ! Escribimos el cabezal del archivo y la primer línea.
   write(10,*) '#t, Th1, Th2, errorTh1, errorTh2'
   analitiks1 = (uno/sqrt(8.0D0))*( a*cos( sqrt(dos - sqrt(dos))*t(1)*w ) - b*cos( sqrt(dos + sqrt(dos))*t(1)*w ) )
   analitiks2 = (uno/sqrt(4.0D0))*( a*cos( sqrt(dos - sqrt(dos))*t(1)*w ) + b*cos( sqrt(dos + sqrt(dos))*t(1)*w ) )
   write(10,100) t(1), Th1(1), Th2(1), abs(analitiks1 - Th1(1)), abs(analitiks2 - Th2(1))


   ! Imprimimos información útil en pantalla.
   write(*,*) '-------------------------------------------'
   write(*,*) '| En un momento terminamos, Camarada UwUr |'
   write(*,*) '-------------------------------------------'

   !===============================================================
   ! Hacemos el método de Runge-Kutta en sí,
   ! encontramos las aproximaciones analíticas
   ! y guardamos todo en el archivo de antes.
   do i=1, Nt-1

      !-------------------------------------------
      call rk4(Th1(i), Th2(i), Xi1(i), Xi2(i))

      !-------------------------------------------
      Th1(i+1) = Th1(i) + ( k1Th1 + dos*k2Th1 + dos*k3Th1 + k4Th1 )*( dt*sexto )
      Th2(i+1) = Th2(i) + ( k1Th2 + dos*k2Th2 + dos*k3Th2 + k4Th2 )*( dt*sexto )
      Xi1(i+1) = Xi1(i) + ( k1Xi1 + dos*k2Xi1 + dos*k3Xi1 + k4Xi1 )*( dt*sexto )
      Xi2(i+1) = Xi2(i) + ( k1Xi2 + dos*k2Xi2 + dos*k3Xi2 + k4Xi2 )*( dt*sexto )

      !-------------------------------------------
      t(i+1) = t(i) + dt

      !-------------------------------------------
      analitiks1 = (uno/sqrt(8.0D0))*( a*cos( sqrt(dos - sqrt(dos))*t(i+1)*w ) - b*cos( sqrt(dos + sqrt(dos))*t(i+1)*w ) )
      analitiks2 = (uno/sqrt(4.0D0))*( a*cos( sqrt(dos - sqrt(dos))*t(i+1)*w ) + b*cos( sqrt(dos + sqrt(dos))*t(i+1)*w ) )

      !-------------------------------------------
      if ( mod(i,savedataT) == 0 ) then
         write(10,100) t(i+1), Th1(i+1), Th2(i+1), abs(analitiks1 - Th1(i+1)), abs(analitiks2 - Th2(i+1))
      end if

   end do

   ! Cerramos el archivo donde escribimos la información.
   close(10)


!-------------------------------------------
! Definimos el formato de escritura en el archivo, este es estilo cvs.
100 format (f20.16,',',f20.16,',',f20.16,',',f20.16,',',f20.16)

end subroutine calibrador
