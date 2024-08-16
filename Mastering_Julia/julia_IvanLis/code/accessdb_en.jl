#
# accessdb_en.jl
#
# Пример использования пакета ODBC с СУБД Access (англ)

using ODBC

path = joinpath(homedir(),"julia_projects","data")
db = joinpath(path,"grocery.accdb")
connstr="DRIVER=Microsoft Access Driver (*.mdb, *.accdb);DBQ=$(db);UID=admin;PWD=;"
dsn = ODBC.DSN(connstr;driver_prompt=UInt16(0))  

res = Any
try
  res = ODBC.query(dsn, "SELECT count(*) FROM Products");
catch
  error("Таблица Products отсутствует");
end

nq = get(res.data[1][1])

res = Any[]
recs = Any     
nrecs = 0
while nrecs < 5
  qid = rand(1:nq);
		 
  sql = """
        SELECT Products.ProductName, Products.UnitPrice, Categories.CategoryName 
		FROM Products, Categories 
		WHERE Products.CategoryID=Categories.CategoryID AND Products.ProductID=$qid
		""";
		
  recs = ODBC.query(dsn, sql);
  push!(res, (get(recs.data[1][1]), get(recs.data[2][1]), get(recs.data[3][1]) ))
  nrecs+=1
end;    
  
ODBC.disconnect!(dsn)
res

