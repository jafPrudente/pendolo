subroutine rk4(theta1, theta2, chi1, chi2)

   !==============================================================!
   !             Esta subrutina es el método del rk4.             !
   !==============================================================!

   ! En sí solo calcula el valor de las k's.

   ! Usamos el módulo 'vars' para tener información de los parámetros de entrada.
   use vars

   implicit none

   ! Declaramos los valores de entrada.
   real(8) theta1, theta2, chi1, chi2

   !-------------------------------------------
   call derivadas( theta1, theta2, chi1, chi2 )

   k1Th1 = dTh1
   k1Th2 = dTh2
   k1Xi1 = dXi1
   k1Xi2 = dXi2

   !-------------------------------------------
   call derivadas( theta1 + medio*k1Th1*dt, theta2 + medio*k1Th2*dt, chi1 + medio*k1Xi1*dt, chi2 + medio*k1Xi2*dt )

   k2Th1 = dTh1
   k2Th2 = dTh2
   k2Xi1 = dXi1
   k2Xi2 = dXi2

   !-------------------------------------------
   call derivadas( theta1 + medio*k2Th1*dt, theta2 + medio*k2Th2*dt, chi1 + medio*k2Xi1*dt, chi2 + medio*k2Xi2*dt )

   k3Th1 = dTh1
   k3Th2 = dTh2
   k3Xi1 = dXi1
   k3Xi2 = dXi2

   !-------------------------------------------
   call derivadas( theta1 + k3Th1*dt, theta2 + k3Th2*dt, chi1 + k3Xi1*dt, chi2 + k3Xi2*dt )

   k4Th1 = dTh1
   k4Th2 = dTh2
   k4Xi1 = dXi1
   k4Xi2 = dXi2

end subroutine rk4

