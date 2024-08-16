#
# main.jl
#
# Линейная регрессия

# Этот и другой обучающий программный код можно найти на https://github.com/forio/julia-tutorials

cd(joinpath(homedir(),"julia_projects","data"))

data = readcsv("gasoline.csv")

# Взять столбцы, которые соответствуют значениям X и
# создать для них новую матрицу
# синтаксис: data[row, column]
# взять всю строку        = data[row, :]
# взять весь столбец      = data[:, column]
# взять диапазон столбцов = data[:, column_a:column_b]

x = data[:, 2:4]
y = data[:, 6]

# Вызвать linreg, чтобы вычислить коэффициенты
coefs = linreg(x, y)
