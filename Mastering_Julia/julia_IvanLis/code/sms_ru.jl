#
# sms_ru.jl
#

using Requests
uri = "http://sms.ru/sms/send";
message = Dict(
           "api_id" => "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa", 
               "from"   => "77777777777", 
               "to"     => "77777777777", 
               "text"   => "Здравствуй, Мир!");
Requests.post(uri; data = message)
