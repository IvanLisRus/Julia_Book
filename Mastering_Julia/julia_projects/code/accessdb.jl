#
# accessdb.jl
#
# Пример использования пакета ODBC с СУБД Access

using ODBC

path = joinpath(homedir(),"julia_projects","data")
db = joinpath(path,"quotes.accdb")
connstr="DRIVER=Microsoft Access Driver (*.mdb, *.accdb);DBQ=$(db);UID=admin;PWD=;CharacterSet=UTF8;Locale Identifier=1049";  #LCID=1049,0419
dsn = ODBC.DSN(connstr;driver_prompt=UInt16(0))  

res = Any
try
  res = ODBC.query(dsn, "SELECT count(*) FROM quotes");
catch
  error("Таблица quotes отсутствует");
end

nq = get(res.data[1][1])

res  = Any[]
recs = Any    

# извлечь 5 произвольных цитат 
nrecs = 0
while nrecs < 5
  qid = rand(1:nq);
  sql = """
        SELECT quotes.author, quotes.quoname, categories.catname 
		FROM quotes, categories 
		INNER JOIN categories ON quotes.id=categories.id WHERE quotes.id=$qid 
		""";
  sql = """
        SELECT quotes.author, quotes.quoname, categories.catname 
		FROM quotes, categories 
		WHERE quotes.id=$qid AND quotes.id=categories.id  
		""";

  recs = ODBC.query(dsn, sql);
  push!(res, (get(recs.data[1][1]), get(recs.data[2][1]), get(recs.data[3][1]) ))
  nrecs+=1
end;    
  
#ODBC.disconnect!(dsn)
res
