program main

   !==============================================================!
   !                Este programa soluciona péndulos.             !
   !==============================================================!

   ! La luna vino a la fragua con su polisón de nardos.

   ! Usamos el módulo 'vars' para tener información de los parámetros de entrada.
   use vars

   ! Por precaución no dejamos ningún tipo implícito.
   implicit none

   ! Llamamos la subrutina que lee la información de entrada.
   call lector

   ! Alojamos en memoria los arreglos a usar.
   allocate( t(Nt), Th1(Nt), Th2(Nt), Xi1(Nt), Xi2(Nt) )

   ! Seleccionamos si queremos solo considerar una solucionr (para calibrar) o el fractal.
   if (selector == 1) then
      call calibrador

   else if(selector == 2) then
      call fractal

   end if

end program
