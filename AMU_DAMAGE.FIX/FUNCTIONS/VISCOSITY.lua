--------------VISCO PARAM -------------------------------

-- This script contains a few function to play with viscosity


-- ##this function calculates a viscosity for a given temp (T), as A= f(T)
function initMu(TempRel)
  if (TempRel < Tlim) then
    AF = A1_SI * math.exp( -Q1/(8.314 * (273.15 + TempRel)))
  elseif (TempRel > 0) then
    AF = A2_SI * math.exp( -Q2/(8.314 * (273.15)))
  else
    AF = A2_SI * math.exp( -Q2/(8.314 * (273.15 + TempRel)))
  end
  glen = (2.0 * AF)^(-1.0/n)
  viscosity = glen * yearinsec^(-1.0/n) * Pa2MPa
  return viscosity
end


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

  -- Lets compute an Enhancement factor in each layere
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
-------------- DAMAGE PARAM -----------------------------
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
