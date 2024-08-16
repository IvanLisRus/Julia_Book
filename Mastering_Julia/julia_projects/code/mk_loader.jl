#
# mk_loader.jl
#

## Перевод данных из файла с разделителями в файл загрузки в базу данных

home    = homedir()
jp      = "julia_projects"

infile  = joinpath(home,jp,"data","quotes.tsv")
outfile = joinpath(home,jp,"data","loader.sql")
runfile = joinpath(home,jp,"code","etl.jl")

run(`julia $(runfile) $(infile) $(outfile)`)
println("SQL-закрузчик успешно записан на диск.")