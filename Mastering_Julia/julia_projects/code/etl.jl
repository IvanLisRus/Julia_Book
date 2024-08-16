#! /Users/malcolm/bin/julia
#
# etl.jl
#

# Проверить число аргументов, вывести описание, если не 1 или 2..

nargs = length(ARGS);

if nargs == 0 || nargs > 2 
    println("использование: etl.jl входной_файл [выходной_файл]");
    exit(); 
end

# Первый аргумент - входной файл
# Второй (необязательный) - выходной файл, иначе направить в STDOUT

infile = ARGS[1];

if nargs == 2 
   outfile = ARGS[2];
   try 
      outf = open(outfile,"w");
   catch
      error("Не могу создать выходной файл: ", outfile);
   end
else
   outf = STDOUT;
end

# Функция-однострочник для удвоения одинарных кавычек
escticks(s) = replace(s,"'","''");

# Считать весь файл в матрицу, первая размерность – это число строк
qq = readdlm(infile,'\t');
n = size(qq)[1];

# Будем хранить все категории в словаре
j = 0;
cats = Dict{AbstractString,Int64}();

# Основной цикл загрузки таблицы цитат
for i = 1:n
  cat = qq[i,1];
  if haskey(cats,cat)
    jd = cats[cat];
  else
    j = j + 1; jd = j;
    cats[cat] = jd;
  end
  sql = "insert into `quotes` values($i,$jd,";  
  if (length(qq[i,2]) > 0)
    sql *= string("'", escticks(qq[i,2]), "',");
  else
    sql *= string("null,");  
  end
  sql *= string("'", escticks(qq[i,3]), "');");
  write(outf,"$sql\n");
end

# Теперь выдадим категории
for cat = keys(cats)
  jd = cats[cat];
  write(outf,"insert into `categories` values($jd,'$cat');\n");  
end

close(outf);  # если выходной_файл = STDOUT, то не даст никаких результатов 
