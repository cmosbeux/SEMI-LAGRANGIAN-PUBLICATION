function bedrock(x,y)
  Lx = 1e5
  Ly = 5e4
  sigma = 5e3

  slope = - 1e-4*x + 7e-9*(Lx/2-x)^2

  fjord = 500*x/Lx * math.exp( -(y - Ly/2 + Ly/5*math.sin(x/Lx*math.pi-math.pi/2) )^2/(2*sigma^2))

  xy_dist = ((y - Ly/2)^2 + (x - Lx/2)^2)
  mount =  300*math.exp(-xy_dist/(2*2e3^2))

  zb = 100 +  slope - fjord + mount
  return zb
end

function surface(x,y)
  Lx = 1e5
  Ly = 5e4
  sigma = 5e3

  slope = - 7e-4*x - 5e-9*(Lx/2-x)^2

  fjord = 500*x/Lx * math.exp( -(y - Ly/2 + Ly/5*math.sin(x/Lx*math.pi-math.pi/2) )^2/(2*sigma^2))

  xy_dist = ((y - Ly/2)^2 + (x - Lx/2)^2)
  mount =  300*math.exp(-xy_dist/(2*2e3^2))

  zs = 200 + slope - fjord*0.1 + mount*0.1
  return zs
end

function beta_coeff(x,y,zb)
  beta = 1 * 10^(zb/200 - 5/2) 
  if zb<0 then
    beta = 10^-6
  end
  return beta
end

function front_pressure(z)
  rhoi = 917
  g = 9.81
  p = - rhoi * g * z
  return p
end
