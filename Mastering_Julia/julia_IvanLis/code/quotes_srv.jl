#
# quotes_srv.jl
#

using HttpServer;
using SQLite;

function db()
  cd(joinpath(homedir(),"julia_projects","data"));
  
  db = SQLite.DB("quotes.db");

  res = Any[];
  try
    res = query(db,"select count(*) from quotes");
  catch
    error("Таблица цитат quotes отсутствует");
  end

  nq = isnull(res.data[1][1]) ? 0 : get(res.data[1][1]);

  @assert nq > 0;

  htmlH = """<!DOCTYPE html>
  <html lang='ru-RU'>
  <head>
  <title>Сервер цитат Julia</title>
  </head>
  <body>""";
    
  htmlF= "</body></html>";
  
  recs = Any     
  nrecs = 0
  while nrecs == 0
    qid = rand(1:nq);
    sql  = "select q.author,c.catname,q.quoname from quotes q ";
    sql *= "join categories c on q.cid = c.id and q.id = $qid";
    recs = query(db,sql);
    nrecs, nflds = size(recs)
  end    

  res = convert(Array,recs.data)
  author  = isnull(res[1][1]) ? "" : get(res[1][1]);
  catname = isnull(res[2][1]) ? "" : get(res[2][1]);
  quotext = isnull(res[3][1]) ? "" : get(res[3][1]);    
    
  htmlB = "<p>$quotext<br/><i>$author ($catname)</i></p>";
  string(htmlH,htmlB,htmlF);    
    
end

http = HttpHandler() do req::Request, res::Response
    resource = req.resource[2:end]
    re = r"(?<prop>\w+=\w+)+|(?<num>\d+$)|(?<alphanum>[^?&]+$)"i    
    
    m = match(re,resource)
    if m == nothing return Response(db()) end   # по умолчанию - случайная цитата
    if m[:num] != nothing return Response("номер записи") end
    if m[:alphanum] != nothing return Response("страница") end
    if m[:prop] != nothing return Response("строка запроса") end

    Response(404)
end

http.events["error"]  = (client, err) -> println(err)
http.events["listen"] = (port)        -> println("Прослушивание на порту $port...")

server = Server(http)
run(server, 8000)