--------------FRICTION PARAM -----------------------------

function friction(alpha)
  if (alpha<-10) then
     beta = 10^(-10)
  elseif (alpha>2) then
     beta = 10^2
  else
     beta = 10^alpha
  end
  return beta 
end

function friction_c1_bounds(c1,min,max)
  if (c1<min) then
     c1 = min
  elseif (c1>max) then
     c1= max
  end
  return c1
end

function friction_exp(alpha)
  if (alpha<-10) then
     alpha_new = -10
  elseif (alpha>2) then
     alpha_new = 2 
  else
     alpha_new = alpha
  end
  return alpha_new
end

function weertman_expchange(alpha,u,v,m,grounded_mask)
  un = (u^2+v^2)^0.5
  
  if (grounded_mask < -0.5) then
    --use a reference friction coefficient for regrounding areas
    cm = 1e-5
  else
    cm = 10^alpha*un^(1-m)
  end 

  return cm
end

function weertman_expchange2(c1,u,v,m,grounded_mask)
  un = (u^2+v^2)^0.5
  
  --use a reference friction coefficient for regrounding areas
  if (grounded_mask < -0.5) then
    cm = 1e-5 
  else
    cm = c1*un^(1-m)
  end 
  
  cm = c1*un^(1-m) 
  return cm
end

function Weertman2Coulomb(c1,u,v, gm, zb,h)
  
  --unit (change it depending on your time unit)
  time_conversion = 1/1.0
  
  --Constants
  --Ice sheet parameters
  m    =   1.0 / 3.0  
  hth  =  46  
  u0   = 300 * time_conversion     
  ri = 910.0
  rw = 1028.0

  -- limiters on c1 (empirical but works!))
  c1_min =  1e-6
  c1_max =  5.0e-2  
  if (c1<c1_min) then
     c1 = c1_min
  elseif (c1>c1_max) then
     c1= c1_max
  end

  --Calculate height above floatation
  zs = zb + h
  haf = zs - h * (1 - ri/rw)

  lbd = haf/hth
  if (lbd > 1 or lbd<0) then
    lbd = 1
  end
   
  --Velocity norm
  un = (u^2+v^2)^0.5
  -- minimal velocity 
  if (un < 1e-1) then
    un = 1e-1
  end 
  coef = un/(un+u0)
  taub = c1 * un
  cr = taub / (coef^m)
  cr = cr * 1.0/lbd
  
  --Define a background value for floating part at 10kPa
  if (gm < 0) then
    cr = 0.01
  end
  --cr treshold based on SSA experiments
  if (cr<5e-3) then
     cr = 5e-3
  elseif (cr>5.0) then
     cr = 5.0
  end
 
  return cr
end

function calculate_haf(zs, h)
  ri = 910.0
  rw = 1028.0
  haf = zs - h * (1 - ri/rw)
  return haf
end


--------------VISCO PARAM -------------------------------

-- This function computes an ajusted viscosity accounting for temperature
-- and damage (from SSA viscosity and temperature viscosity)
function initMuSSA(TempRel, MuSSA)
  if (TempRel < Tlim) then
    AF = A1_SI * math.exp( -Q1/(8.314 * (273.15 + TempRel)))
  elseif (TempRel > 0) then
    AF = A2_SI * math.exp( -Q2/(8.314 * (273.15)))
  else
    AF = A2_SI * math.exp( -Q2/(8.314 * (273.15 + TempRel)))
  end
  glen = (2.0 * AF)^(-1.0/n)
  viscosity = glen * yearinsec^(-1.0/n) * Pa2MPa

  -- Lets compute an Enhancement factor in each laye
  Ef = MuSSA - viscosity 
  if (Ef<1e-2) then 
    Ef = 1e-2
  end
  
  -- now we can modify the pure ice viscosity
  viscosity = Ef*viscosity 

  return viscosity
end

function Visco2Ef(Ef)
  E = (Ef)^(-6.0)
  if (E < 0.1) then 
     E = 0.1
  elseif (E>5.0) then
     E = 5.0
  end
  return E
end

function damage(Ef,ratio)
  if (Ef^2<1) then
     E = (ratio+(1-ratio)*Ef^2)^0.5
  else
     E = Ef
  end 
  return E
end

function Ef2Damage(Ef)
  Ef = Ef^2
  D = 1-Ef^2
  return D
end

function Damage2Viscosity(D,Ef, mu)
  if (Ef<0) then
    Ef=0
  elseif (Ef>1) then
    Ef=1
  end 
  visco = (1-D)*(Ef^2)*mu
  return visco
end

--------------MELT PARAM -------------------------------

--Melt rate parametrization (Pollard and DeConto, 2012)
function meltrate_PD2012(zb)
  Tlim1 = -170
  Tlim2 = -680  
  Kt = 15.77
  Lf = 335
  rw = 1028.0
  ri = 917.0
  Cw = 4.218
 
  if (zb>Tlim1) then
     Tdiff = 0.5
  elseif (zb<Tlim2) then
     Tdiff = 3.5
  else
     Tdiff = 0.5 + (zb-Tlim1)/(Tlim2-Tlim1)*3.0
  end
 
  coeff = 8*Kt*rw*Cw*(ri*Lf)^(-1.0)
  melt = coeff*math.abs(Tdiff)*(Tdiff)
  return melt
end
