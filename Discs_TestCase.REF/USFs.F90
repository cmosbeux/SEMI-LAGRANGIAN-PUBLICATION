      
      FUNCTION PhiIni(Model,nodenumber,VarIn) RESULT(VarOut)
      USE TYPES
       implicit none
       !-----------------
       TYPE(Model_t) :: Model
       INTEGER :: nodenumber
       REAL(kind=dp) :: VarIn(2) !x,y
       REAL(kind=dp) :: VarOut
       !-----------------
       REAL(kind=dp),parameter :: x0=0.5,y0=0.5
       REAL(kind=dp) :: x,y

        x=VarIn(1)
        y=VarIn(2)

        VarOut=atan2(y-y0,x-x0)

      End FUNCTION PhiIni

      
      
      FUNCTION HIni(Model,nodenumber,VarIn) RESULT(VarOut)
      USE TYPES
       implicit none
       !-----------------
       TYPE(Model_t) :: Model
       INTEGER :: nodenumber
       REAL(kind=dp) :: VarIn(2) !x,y
       REAL(kind=dp) :: VarOut
       !-----------------
       REAL(kind=dp) :: x,y

        x=VarIn(1)
        y=VarIn(2)

        VarOut=Cone(x,y)+Bump(x,y)+ Cylinder(x,y)

      CONTAINS

      FUNCTION Cone(x,y) RESULT(VarOut)
      USE TYPES
       implicit none
       !-----------------
       REAL(kind=dp) :: VarOut
       !-----------------
       REAL(kind=dp) :: x,y,r
       REAL(kind=dp),parameter :: x0=0.5,y0=0.25,r0=0.15

        r=sqrt((x-x0)**2.0+(y-y0)**2.0)
        VarOut=max(1.0-r/r0,0.0)

      End FUNCTION Cone


      FUNCTION Bump(x,y) RESULT(VarOut)
      USE TYPES
       implicit none
       !-----------------
       REAL(kind=dp) :: VarOut
       !-----------------
       REAL(kind=dp) :: x,y,r
       REAL(kind=dp),parameter :: x0=0.25,y0=0.5,r0=0.15

        r=sqrt((x-x0)**2.0+(y-y0)**2.0)/r0

        VarOut=0.5*(1.0+cos(Pi*min(r,1.0_dp)))


      END FUNCTION Bump

      FUNCTION Cylinder(x,y) RESULT(VarOut)
      USE TYPES
       implicit none
       !-----------------
       REAL(kind=dp) :: VarOut
       !-----------------
       REAL(kind=dp) :: x,y,r
       REAL(kind=dp),parameter :: x0=0.5,y0=0.75,r0=0.15

       r=sqrt((x-x0)**2.0+(y-y0)**2.0)/r0

       if ((r.LT.1.0_dp).AND.((abs(x-x0).GT.0.0225).OR.(y.GT.0.85))) THEN
          VarOut=1.0_dp
       else
          VarOut=0.0_dp
       endif
      END FUNCTION Cylinder


      End FUNCTION HIni
