@echo off

@echo Creating loader (ru)...

rem julia C:\Users\labor\julia_projects\code\etl.jl quotes.tsv loader.sql

@echo Creating Sqlite db file (ru)...

sqlite\sqlite3.exe quotes.db < build.sql 
sqlite\sqlite3.exe quotes.db < loader.sql

@echo Finished.

