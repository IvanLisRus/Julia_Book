#
# lena2.jl
#

# версия 2

cd(joinpath(homedir(),"julia_projects","images"))

img = open("lena.pgm");

magic = chomp(readline(img));
params = chomp(readline(img));

while ismatch(r"^\s*#", params)
  params = chomp(readline(img));
end

pm = split(params);

if length(pm) < 3
  params *= " " * chomp(readline(img));
end

wd = parse(Int, pm[1]);
ht = parse(Int, pm[2]);
data = round(UInt8, readbytes(img,wd*ht));
data = reshape(data,wd,ht);

close(img);

Gx = [1 2 1; 0 0 0; -1 -2 -1];
Gy = [1 0 -1; 2 0 -2; 1 0 -1];

dout = copy(data);

for i = 2:wd-1
  for j = 2:ht-1
    temp = data[i-1:i+1, j-1:j+1];
    x = sum(Gx.*temp)
    y = sum(Gy.*temp)
    p = round(Int, sqrt(x*x + y*y))
    dout[i,j] = (p < 256) ? UInt8(p) : 0xff
  end
end

out = open("lenaX2.pgm","w");

println(out,magic);
println(out,params);

write(out,dout);

close(out); 

println("Изображение обработано.");
