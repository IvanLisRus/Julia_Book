#
# couchdb_books.jl
#

using Requests, JSON

url = "http://localhost:5984"
uu = Requests.get(url);
json = JSON.parse(bytestring(uu.data))


# Создать новую базу данных

# run(`curl -X PUT http://localhost:5984/quotes_ru`)   #/цитаты ?

url = "http://localhost:5984/quotes"
Requests.put(url);


#run(`curl http://localhost:5984/_all_dbs`)

url = "http://localhost:5984/_all_dbs"
uu = Requests.get(url);
json = JSON.parse(bytestring(uu.data))



# curl -H 'Content-Type: application/json' -X POST http://127.0.0.1:5984/quotes -d '{category:"...",author:"...", "quote":"..."}'

url = "http://localhost:5984/quotes"
json = Dict("category" => "Computing", 
            "author" => "Scott's Law", 
            "quote" => "Adding manpower to a late software project makes it later") 
uu = Requests.post(url, json = json)


cd(joinpath(homedir(),"julia_projects","data"))
include("quotes_arr.jl")
 
 
 
cdb = "http://localhost:5984";
qc = cdb * "/quotes";

for json in quotes_arr
  Requests.post("$qc", json=json)
end

println("Данные успешно внесены.")



cdb = "http://localhost:5984"
qc_all = cdb * "/quotes/_all_docs"

res = bytestring(Requests.get(qc_all).data);
json = JSON.parse(res) 



json["total_rows"]    
json["rows"][2]      # Выделить конкретную запись



qc = cdb * "/quotes";

key = json["rows"][2]["key"];
rev = json["rows"][2]["value"]["rev"];

JSON.parse(bytestring(Requests.get("$qc/$key").data))



Requests.delete("$qc/$key?rev=$rev")



json = Dict("category" => "Books & Plays", "author" => "Oscar Wilde", "quote" => "I can resist everything but temptation")

Requests.delete("$qc/$key?rev=$rev")
Requests.post("$qc", json=json)

