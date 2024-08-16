#
# asian_option_with_args.jl
#

function run_asian(N = 100000, PutCall = 'C';)
# Евроазиатский опцион.
#
# Использует геометрическое либо арифметическое усреднение.
# Дискретизация по методу Эйлера и Мильштейна для формулы Блэка-Шоулса.
# Характеристики опциона.

  println("Установка параметров опциона"); 
  
  S0  = 100;     # Цена "спот" или цена немедленной поставки
  K   = 100;     # Цена "страйк" или цена исполнения
  r   = 0.05;    # Безрисковая ставка
  q   = 0.0;     # Дивидендная доходность  
  v   = 0.2;     # Волатильность
  tma = 0.25;    # Срок до даты платежа

  Averaging = 'A';    # 'A' арифметическое или 'G' геометрическое 
  OptType = (PutCall == 'C' ? "CALL" : "PUT");
  
  println("Тип опциона: $OptType");

# Настройки моделирования.
  println("Установка параметров моделирования"); 
  
  T  = 100;      # Число временных интервалов 
  dt = tma/T;    # Приращение времени

# Инициализировать матрицы терминальной фондовой цены
# для схем дискретизации по методу Эйлера и Мильштейна. 
  S = zeros(Float64,N,T);
    for n=1:N 
      S[n,1] = S0;
    end

# Смоделировать фондовую цену в условиях схем Эйлера и Мильштейна.
# Взять среднее терминальной фондовой цены. 

  println("Повторяем $N раз.");
  
  A = zeros(Float64,N); 
    for n=1:N
      for t=2:T
        dW = (randn(1)[1])*sqrt(dt);
        z0 = (r - q - 0.5*v*v)*S[n,t-1]*dt; 
        z1 = v*S[n,t-1]*dW;
        z2 = 0.5*v*v*S[n,t-1]*dW*dW; 
        S[n,t] = S[n,t-1] + z0 + z1 + z2;
      end
    if cmp(Averaging,'A') == 0 
      A[n] = mean(S[n,:]);
    elseif cmp(Averaging,'G') == 0 
      A[n] = exp(mean(log(S[n,:])));
    end 
  end

# Рассчитать премию
  P = zeros(Float64,N);
  if cmp(PutCall,'C') == 0 
    for n = 1:N
      P[n] = max(A[n] - K, 0);
    end
  elseif cmp(PutCall,'P') == 0 
    for n = 1:N
      P[n] = max(K - A[n], 0);
    end 
  end

  # Рассчитать цену Азиатского опциона 
  AsianPrice = exp(-r*tma)*mean(P);
  
  @printf "Цена опциона: %10.4f\n" AsianPrice; 
end


nArgs = length(ARGS) 

if nArgs >= 2
  run_asian(parse(Int,ARGS[1]), convert(UInt8,ARGS[2][1])) 
elseif nArgs == 1
  run_asian(parse(Int,ARGS[1]))
else
  run_asian()
end
