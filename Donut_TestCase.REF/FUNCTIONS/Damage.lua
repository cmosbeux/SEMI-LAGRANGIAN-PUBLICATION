--------------FRICTION PARAM -----------------------------

function Damage_source_limiter(Damage, Source, dt)
  D = Damage + Source*dt
  if (D<0.0) then
     D = 0.0
  elseif (D>0.7) then
     D = 0.7
  end
  return D
end

function v_lim(v)
  if (v<0.1) then
     v = 0.1
  end
  return v
end
