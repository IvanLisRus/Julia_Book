#
# asian_winstonplot.jl
#
# Примечание:
#
# Под OSX имелись небольшие проблемы с использованием модуля Pango, 
# который является частью пакета Winston, при отображении заголовков, текста и пр.
#
# Проблема, вероятно, связана с менеджером недостающих пакетов Homebrew, и
# следующая процедура ее решает.
# Она выполняется всего один раз.
# 
# using Homebrew 
# Homebrew.update() 
# Homebrew.rm("pango")
# Homebrew.add("pango") 
#

import Winston;
wn = Winston;

S0  = 100;      # Цена "спот"
K   = 102;      # Цена "страйк"
r   = 0.05;     # Безрисковая ставка 
q   = 0.0;      # Дивидендная доходность  
v   = 0.2;      # Волатильность
tma = 0.25;     # Срок до даты платежа 
T   = 100;      # Число временных интервалов  
dt  = tma/T;    # Приращение времени

S = zeros(Float64,T)
S[1] = S0;	

dW = randn(T)*sqrt(dt);
[ S[t] = S[t-1] * (1 + (r - q - 0.5*v*v)*dt + v*dW[t] + 0.5*v*v*dW[t]*dW[t]) for t=2:T ]
x = linspace(1, T, T);

p = wn.FramedPlot(title = "Случайное блуждание, сдвиг 5%, волатильность 20%")
wn.add(p, wn.Curve(x,S,color="red"))

wn.display(p)