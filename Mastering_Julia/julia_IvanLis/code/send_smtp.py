# Импортировать библиотеку smtplib для доступа к функции пересылки
import smtplib

# Импортировать почтовые модули, которые потребуются в дальнейшем
from email.mime.text import MIMEText

# Открыть файл с текстом без форматирования для чтения.  В этом примере примем, что
# ткстовый файл содержит только символы в ASCII кодировке.
fp = open(textfile, 'rb')

# Создать сообщение с MIME text/plain 
msg = MIMEText(fp.read())
fp.close()

# me == электронный адрес отправителя
# you == электронный адрес получателя
msg['Subject'] = 'Содержание %s' % textfile
msg['From'] = me
msg['To'] = you

# Отправить сообщение через наш сервер SMTP, но не вклучая заголовок контейнера envelope header.
s = smtplib.SMTP('localhost')
s.sendmail(me, [you], msg.as_string())
s.quit()