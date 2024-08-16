#
# cdb_quotes_load.jl
#
# Загрузчик цитат в CouchDB (рус)

cd(joinpath(homedir(),"julia_projects","data"))


using Requests


couchdb = "http://localhost:5984/"
db  = "quotes"
tsv = "quotes.tsv"     # кодировка UTF-8 (без BOM) !!


# подготовка данных из файла .tsv

txt = readall(tsv)
arr = split(chomp(txt),"\n")


# преобразование в словарь

dict = Dict[]

for el in arr
  rec = split(chomp(el),"\t")
  length(rec) < 2 && error("Некорректная запись.")
  if length(rec) == 2
    d = Dict("category" => rec[1], "quote" => rec[2])
  else
    d = Dict("category" => rec[1], "author" => rec[2], "quote" => rec[3])
  end
  push!(dict, d)
end


# создание бд

Requests.put(couchdb * db);


# загрузка в Couch DB
 
qc = couchdb * db;
for json in dict
  Requests.post("$qc", json=json)
end


