#
# lotka_volterra1.jl
#
# Динамическая система (уравнения Лотки-Вольтерры)

function F(t,x,p)
  d1 =  p[1]*x[1] - p[2]*x[1]*x[2]
  d2 = -p[3]*x[2] + p[4]*x[1]*x[2] - p[5]*x[2]*x[3]
  d3 = -p[6]*x[3] + p[7]*x[2]*x[3]
  [d1, d2, d3]
end

p = ones(7);                      # принять все параметры за 1.0
x0 = collect([0.5, 1.0, 2.0]);    # Установить начальные условия
tspan = collect([0.0:0.1:10.0]);  # и период времени

using ODE

(t,x) = ODE.ode23((t,x) -> F(t,x,p), x0, tspan);

n = length(t);

y1 = zeros(n); [y1[i] = x[i][1] for i = 1:n]; 
y2 = zeros(n); [y2[i] = x[i][2] for i = 1:n];
y3 = zeros(n); [y3[i] = x[i][3] for i = 1:n];

using Winston

Winston.plot(t,y1,"b.",t,y2,"g-.",t,y3,"r--")
