subroutine derivadas( T1, T2, X1, X2 )

   !==============================================================!
   !     Esta subrutina tiene escritas las EDO's a solucionar.    !
   !==============================================================!

   ! Usamos el módulo 'vars' para tener información de los parámetros de entrada.
   use vars

   implicit none

   ! Declaramos las variables que usaremos.
   real(8) T1, T2, X1, X2
   real(8) gamma, delta
   real(8) c1, c2

   ! Definimos variables auxiliares.
   gamma = uno + alpha*sin(T1 - T2)**2
   delta = X1**2 + alpha*(beta**2)*(uno + alpha)*(X2**2) - dos*alpha*beta*X1*X2*cos(T1 - T2)
   c1    = ( alpha*beta*X1*X2*sin(T1 - T2) ) / gamma
   c2    = ( alpha*delta*sin( dos*(T1 - T2) ) )/( dos*gamma**2 )

   ! Definimos en sí las ecuaciones diferenciales.
   dTh1 = ( X1 - alpha*beta*X2*cos(T1 - T2) )/gamma
   dTh2 = ( alpha*(beta**2)*(uno + alpha)*X2 - alpha*beta*X1*cos(T1 - T2) ) / gamma
   dXi1 = -(w**2)*(uno + alpha)*sin(T1) - c1 + c2
   dXi2 = -(w**2)*alpha*beta*sin(T2) + c1 - c2

end subroutine derivadas
