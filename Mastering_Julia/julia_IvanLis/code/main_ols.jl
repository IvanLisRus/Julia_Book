#
# main_ols.jl
#

cd(joinpath(homedir(),"julia_projects"))

include("code/ols.jl")

data = readcsv("data/gasoline.csv")

# Взять столбцы, которые соответствуют значениям X и
# создать для них новую матрицу
# синтаксис: data[row, column]
# взять всю строку        = data[row, :]
# взять весь столбец      = data[:, column]
# взять диапазон столбцов = data[:, column_a:column_b]

x = [data[:,2] data[:,3] data[:,4]]
y = data[:,6]

# Создать новый объект OLS
reg = ols.tols(y, x, "Octane Rating", ["Error", "Component 1", "Component 2", "Component 3"])


