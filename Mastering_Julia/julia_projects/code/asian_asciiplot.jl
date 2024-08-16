#
# asian_asciiplot.jl
#

using ASCIIPlots;

S0  = 100;      # Цена "спот"
K   = 102;      # Цена "страйк"
r   = 0.05;     # Безрисковая ставка 
q   = 0.0;      # Дивидендная доходность  
v   = 0.2;      # Волатильность
tma = 0.25;     # Срок до даты платежа 
T   = 100;      # Число временных интервалов  
dt  = tma/T;    # Приращение времени

S = zeros(Float64,T);
S[1] = S0;
dW = randn(T)*sqrt(dt)
[ S[t] = S[t-1] * (1 + (r - q - 0.5*v*v)*dt + v*dW[t] + 0.5*v*v*dW[t]*dW[t]) for t=2:T ]
x = linspace(1,100,T);

scatterplot(x,S,sym='*')