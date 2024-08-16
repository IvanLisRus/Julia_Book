#
# rest_books.jl
#

using Requests
#import Requests: get, post, put, delete, options
using JSON

api = "https://www.googleapis.com/books/v1/volumes"
url = api * "?q=isbn:1408855895";

uu = get(url);

json = JSON.parse(bytestring(uu.data));

volumeInfo = json["items"][1]["volumeInfo"];
title = volumeInfo["title"];
author = volumeInfo["authors"][1];
publisher = volumeInfo["publisher"];
pubdate = volumeInfo["publishedDate"];
ppcount = volumeInfo["pageCount"];

@printf "%s, автор: %s\nОпубликовано: %s (%s), кво страниц: %d" title author publisher pubdate ppcount
