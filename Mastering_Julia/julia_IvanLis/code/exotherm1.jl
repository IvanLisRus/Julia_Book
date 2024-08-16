#
# exotherm1.jl
#

using Sundials

function exotherm1(t, x, dx; n=1, a=1, b=1) # экзотермическая реакция
  p = x[2]^n * exp(x[1])
  dx[1] = p - a*x[1]
  dx[2] = -b*p
  dx
end

t = linspace(0.0,5.0,1001);
fexo(t,x,dx) = exotherm1(t, x, dx, a=0.6, b=0.1);

x1 = Sundials.cvode(fexo, [0.9, 1.0], convert(Array, t));

using Winston

plot(t,x1[:,1])

