#! /Users/malcolm/bin/julia -q
#
# epipe.jl
#
# Выполняет обработку нескольких команд
# использование: ./echo.jl [ -q ] [ -p <port> ]  [-h <host> ] 
# только для UNIX-подобных ОС (!)

epipe = "/tmp/epipe" 

server = listen(epipe)
while true
  conn = accept(server)
  @async begin
    try
      while true
        s0 = readline(conn)
        s1 = chomp(s0) 
        if length(chomp(s1)) > 0 
          s2 = reverse(s1)
          if s2 == "." 
            println("Готово.")
            close(conn)
            exit(0)
          else
            write(conn,string(s2,"\r\n"))
          end
        end
      end
    catch err
      println("Соединение утеряно:  $err")
      exit(1)
    end
  end
end
