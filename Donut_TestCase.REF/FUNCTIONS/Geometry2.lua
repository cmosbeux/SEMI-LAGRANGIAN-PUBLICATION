function bedrock(x,y, h_mount)
  Lx = 1e5
  Ly = 5e4
  sigma = 5e3

  slope = - 5e-4*x --+ 7e-9*(Lx/2-x)^2

  xy_dist = ((y - Ly/2)^2 + (x - Lx/2)^2)
  mount =  h_mount*math.exp(-xy_dist/(2*2e3^2))

  zb = 100 +  slope + mount
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
  beta = 10^-6
  return beta
end

function front_pressure(z)
  rhoi = 917
  g = 9.81
  p = - rhoi * g * z
  return p
end

function tracer(x,y)
  Lx = 1e5
  Ly = 5e4
  sigma = 5e3
 
  xy_dist = ((y - Ly/2)^2 + (x - Lx/4)^2)
  
  tr = 0.0
  if (xy_dist^0.5<1e4 and xy_dist^0.5>5e3) then
    tr =  1.0
  end  
  return tr
end 

function tracer_gauss(x,y)
  Lx = 1e5
  Ly = 5e4
  sigma = 5e3

  xy_dist = ((y - Ly/2)^2 + (x - Lx/4)^2)

  tr = math.exp(-xy_dist / (2 * sigma^2))

  return tr
end

function tracer_line(x,y)
  Lx = 1e5
  Ly = 5e4
  sigma = 5e3

  xy_dist = (x - Lx/4)^2

  tr = math.exp(-xy_dist / (2 * sigma^2))

  return tr
end



function limiter(x,min,max)
  if (x < min ) then
    x = min
  elseif (x > max) then
    x = max
  end
  return x
end
