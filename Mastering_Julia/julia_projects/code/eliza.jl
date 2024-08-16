#
# eliza.jl
#
# Работает с расширением Simple WebSockets в браузере Chrome

using HttpServer
using WebSockets

const SDEF = "Расскажите подробнее...";
const SBYE = "До свидания! Давайте повторим нашу беседу в ближайшее время.";

d = Dict();

d["привет"]   = "Привет! Меня зовут Элиза.";
d["нет"]      = "Будьте добры, об этом по-подробнее.";
d["да"]       = "Будьте добры, по-подробнее об этом.";
d["вы"]       = "Давайте не будем говорить обо мне.";
d["думаю"]    = "Почему Вы так думаете?";
d["ненавижу"] = "Так, значит, Вы испытываете ненависть к чему-то. Расскажите об этом.";
d["что"]      = "А почему Вы спрашиваете?"; 
d["хочу"]     = "Я здесь, чтобы помочь Вам разобратьтся в своих желаниях.";
d["нужно"]    = "Нам всем чего-то не хватает. Это для Вас важно?";
d["почему"]   = "Запомните, терапия благоприятно отразится на Вас.";
d["знаю"]     = "Откуда Вам известно это?";
d["не могу"]  = "Не будьте такими негативными. Больше позитива!";
d["never"]    = "Не будьте такими негативными. Больше позитива!";
d["несчастен"] = "Почему Вы несчастны?";
d["несчастна"] = "Почему Вы несчастны?";
d["огорчает"] = "Почему Вас это огорчает?";
d["нравится"] = "Почему Вам это нравится?";
d["помогите"] = "Я здесь, чтобы помочь Вам.";
d["помощь"]   = "Я здесь, чтобы Вам помочь.";

wsh = WebSocketHandler() do req,client
  looping = true; 
  while looping
    s0 = lowercase(bytestring(read(client)))
    s1 = SDEF
    if ismatch(r"^\s*пока"i, s0)    
      looping = false
      s1 = SBYE
    else
      for k in keys(d)
        s = lowercase(k)
        if contains(s0, s)
          s1 = d[k]
          break
        end
      end
    end
    write(client, "ЭЛИЗА> $s1")
  end
end
    
server = Server(wsh)
run(server,8080)       # ip"127.0.0.1"