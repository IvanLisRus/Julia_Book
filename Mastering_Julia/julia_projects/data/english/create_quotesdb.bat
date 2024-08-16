@echo off

@echo Creating Loader...

julia C:\Users\labor\julia_projects\code\etl.jl quotes.tsv loader.sql

@echo Creating Sqlite DB File (en)...

cd C:\Users\labor\julia_projects\data\english

..\sqlite\sqlite3.exe quotes.db < build.sql 
..\sqlite\sqlite3.exe quotes.db < loader.sql

@echo Finished.