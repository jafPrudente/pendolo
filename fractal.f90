subroutine fractal

   !==============================================================!
   !          Esta subrutina guada los datos del fractal.         !
   !==============================================================!

   !===============================================================
   ! Usamos el módulo 'vars' para tener información de los parámetros de entrada.
   use vars

   ! Por precaución no dejamos ningún tipo implícito.
   implicit none

   ! Declaramos variables útiles.
   integer i, j, k
   real(8) tg, tl
   real(8), allocatable, dimension (:) :: tiempo_g, tiempo_l
   allocate( tiempo_g(Nx*Nx), tiempo_l(Nx*Nx) )

   !===============================================================
   ! Definimos las condiciones iniciales.
   Th1(1) = -pi
   Th2(1) = -pi
   Xi1(1) = cero
   Xi2(1) = cero

   t(1) = cero

   !===============================================================
   ! Abrimos un archivo para guardar los datos, accedemos a él con la etiqueta '10'.
   open(20, file = 'fractal.csv', status = 'replace')

   ! Escribimos el cabezal del archivo.
   write(20,*) '#Th1, Th2, tg, tl'

   ! Imprimimos en terminal información útil.
   write(*,*) '---------------------------------'
   write(*,*) '| Vamos a comenzar a solucionar |'
   write(*,*) '---------------------------------'
   write(*,*) '|     Línea     |     Total     |'
   write(*,*) '---------------------------------'

   ! Iniciamos el contador de líneas y el contador de índices para los tiempos.
   j = 1
   k = 0

   ! Llenamos el arreglo temporal.
   do i=1, Nt-1
      t(i+1) = t(i) + dt
   end do

   !===============================================================
   ! Iniciamos los ciclos.
   do while (Th1(1) <= pi)

      do while (Th2(1) <= pi)

         !---------------------------------------------------------------
         ! Solucionamos solo la mitad izquierda.
         if (Th1(1) <= 0) then

            ! Esta es la condición de giro.
            if ( alpha*beta*cos(Th2(1)) + (1+alpha)*cos(Th1(1)) > 1 + alpha*(1-beta) ) then

               !---------------------------------------------------------------
               ! Si no gira ni latigea podemos decir que lo hace al tiempo final.
               tg = tf
               tl = tf

               !---------------------------------------------------------------
               ! Escribimos la información en el archivo.
               write(20,200) Th1(1), Th2(1), tg, tl

               !---------------------------------------------------------------
               ! Guardamos el tiempo de giro y latiganzo en un arreglo.
               tiempo_g(k) = tg
               tiempo_l(k) = tl

            else
               !---------------------------------------------------------------
               ! Si no se cumple la condición calculemos en qué momento gira.

               ! Hacemos el método de Runge-Kutta en sí.
               do i=1, Nt-1

                  !-------------------------------------------
                  call rk4(Th1(i), Th2(i), Xi1(i), Xi2(i))

                  !-------------------------------------------
                  Th1(i+1) = Th1(i) + ( k1Th1 + dos*k2Th1 + dos*k3Th1 + k4Th1 )*( dt*sexto )
                  Th2(i+1) = Th2(i) + ( k1Th2 + dos*k2Th2 + dos*k3Th2 + k4Th2 )*( dt*sexto )
                  Xi1(i+1) = Xi1(i) + ( k1Xi1 + dos*k2Xi1 + dos*k3Xi1 + k4Xi1 )*( dt*sexto )
                  Xi2(i+1) = Xi2(i) + ( k1Xi2 + dos*k2Xi2 + dos*k3Xi2 + k4Xi2 )*( dt*sexto )

               end do

               !---------------------------------------------------------------
               ! Reiniciamos los tiempos de giro y latiganzo.
               tg = tf
               tl = tf

               !---------------------------------------------------------------
               ! Calculamos el tiempo de giro.
               do i = 1, Nt
                  if ( ( abs(Th1(i)) >= pi ) .or. ( abs(Th2(i)) >= pi ) ) then
                     tg = t(i-1)
                     exit
                  end if
               end do

               !---------------------------------------------------------------
               ! Calculamos el tiempo de latiganzo.
               do i = 1, Nt
                  if ( Xi1(i)*Xi2(i) <= 0 ) then
                     tl = t(i-1)
                     exit
                  end if
               end do

               !---------------------------------------------------------------
               ! Escribimos la información en el archivo.
               write(20,200) Th1(1), Th2(1), tg, tl

               !---------------------------------------------------------------
               ! Guardamos el tiempo de giro y latiganzo en un arreglo.
               tiempo_g(k) = tg
               tiempo_l(k) = tl
            end if

            !---------------------------------------------------------------
            ! Actualizamos el contador de los tiempos.
            k = k + 1

            !---------------------------------------------------------------
            ! Hacemos la reflexión para la mitad derecha.
         else
            !---------------------------------------------------------------
            ! Calculamos los tiempos de giro y latiganzo en función de los ya guardados.
            tg = tiempo_g(k)
            tl = tiempo_l(k)

            !---------------------------------------------------------------
            ! Escribimos en el archivo.
            write(20,200) Th1(1), Th2(1), tg, tl

            !---------------------------------------------------------------
            ! Movemos el contador de los tiempos al contrario.
            k = k - 1
         end if

         ! Damos un paso hacia arriba en la línea para \theta_2(0).
         Th2(1) = Th2(1) + dx

      end do

      ! Damos un paso en la malla para \theta_1(0) y reiniciamos el valor de \theta_2(0).
      Th1(1) = Th1(1) + dx
      Th2(1) = -pi

      ! Imprimimos en pantalla en qué línea vamos.
      write(*,"(a5,i7,a9,i7,a6)") ' |   ',j,'     de  ',Nx,'     |'

      ! Actualizamos el contador de líneas.
      j = j + 1

   end do

   ! Imprimimos información útil en pantalla.
   write(*,*) '---------------------------------'
   write(*,*) '| Ya terminamos, Camarada UwUr  |'
   write(*,*) '---------------------------------'

   ! Cerramos el archivo donde escribimos la información.
   close(20)

! Definimos el formato de escritura en el archivo, este es estilo cvs.
200 format (f20.16,',',f20.16,',',f20.16,',',f20.16)

end subroutine fractal
