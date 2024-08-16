#
# py_email.jl
#

using PyCall;

@pyimport smtplib;

fromaddr = "malcolm.sherrington@gmail.com";
toaddrs = "malcolm@amisllp.com";

messy = """From: $fromaddr
To: $toaddrs
Subject: Проверка SMTP при помощи PyCall

Проверка - 1,2,3
""";

# Отметим, что пустая строка необходима для различения
# заголовка SMTP от текста сообщения.

username = fromaddr;
password = "ABCDEF7890"; # ненастоящий пароль

server = pycall(smtplib.SMTP,PyAny,"smtp.gmail.com:587");
server[:ehlo]();
server[:starttls]();
server[:login](username,password);
server[:sendmail](fromaddr,toaddrs,messy);
server[:quit](); 