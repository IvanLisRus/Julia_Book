#
# quotes_srv_ext.jl
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
    error("Таблица цитат quotes_ru отсутствует");
  end

  nq = isnull(res.data[1][1]) ? 0 : get(res.data[1][1]);

  @assert nq > 0;

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
    
    
  css1 = readall("site/css/default.css")
  css2 = readall("site/css/layout.css")    
    
  html = """
<!DOCTYPE html>
<!--[if lt IE 8 ]><html class="no-js ie ie7" lang="ru"> <![endif]-->
<!--[if IE 8 ]><html class="no-js ie ie8" lang="ru"> <![endif]-->
<!--[if (gte IE 8)|!(IE)]><!--><html class="no-js" lang="ru"> <!--<![endif]-->
<head>
   <meta charset="utf-8">
   <title>Сервер цитат</title>
   <meta name="description" content="">
   <meta name="author" content="">
   <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
   <!--link rel="stylesheet" href="site/css/default.css">
   <link rel="stylesheet" href="site/css/layout.css"-->
    
   <style>$(css1)</style>
   <style>$(css2)</style>    

</head>
<body>
   <header id="home">
      <div class="row banner">
    <div class="banner-text">
    <h1 class="responsive-headline">$(author)</h1>
            <h3>$(catname) - <span>$(quotext)</span></h3>
            <hr />
         </div>
      </div>
   </header> 
</body>
</html>
    """;
  html;    
    
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
