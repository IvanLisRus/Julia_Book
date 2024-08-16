#
# knapsack.jl
#
# Решение задачи о ранце

using JuMP     # требует установки пакета с решателем задач Cbc, MIB...

N = 6;

m = Model();                      # Использовать решатель по умолчанию
@variable(m, x[1:N], Bin);        # Определить переменную массива для результатов
profit = [ 5, 3, 2, 7, 4, 4 ];    # Массив стоимостей размера N
weight = [ 2, 8, 4, 2, 5, 6 ];    # Вектор весов такого же размера

capacity = 12;

@objective(m, Max, dot(profit, x));
@constraint(m, dot(weight, x) <= capacity);

status = solve(m);               # Решить задачу с помощью решателя MIP 
@printf "Значение целевой функции: %.1f" getobjectivevalue(m);

for i = 1:N
  print("x[$i] = ", getvalue(x[i]));
  println(", p[$i]/w[$i] = ", profit[i]/weight[i]);
end