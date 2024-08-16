#
# exotherm2.jl
#

using Sundials

function exotherm1(t, x, dx; n=1, a=1, b=1) # экзотермическая реакция
  p = x[2]^n * exp(x[1])
  dx[1] = p - a*x[1]
  dx[2] = -b*p
  dx
end


t = linspace(0.0,5.0,1001);
arr = [0.9, 1.2, 1.5, 1.8]
res = Any[]

for el in arr
  fexo(t,x,dx) = exotherm1(t, x, dx, a=el, b=0.1);
  push!(res, Sundials.cvode(fexo, [0.0, 1.0], convert(Array, t)));   
end

using Winston

plot(t,res[1][:,1],t,res[2][:,1],t,res[3][:,1],t,res[4][:,1])
