function limiter_bounds(val, min, max)
  if (val< min) then
     val = min
  elseif (val>max) then
     val = max
  end
  return val
end

function limiter_damage(val, mask, min, max)
  if (val< min) then
     val = min
  elseif (val>max) then
     val = max
  end
 
  if (mask>0.5) then
    val = 0.0
  end

  return val
end

function limiter_bounds_stabilized(val,  min, max)
  if (val< min) then
     val = min
  elseif (val>max) then
     val = max
  end
  return val
end
