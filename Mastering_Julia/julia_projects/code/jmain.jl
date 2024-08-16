#
# jmain.jl
#

include("jset.jl")
include("jpgmfile.jl")

cd(joinpath(homedir(), "julia_projects","images"))

h = 400; w = 800; m = Array(Int64, h, w);
c0 = -0.8+0.16im;

pgm_name = "julia.pgm";

t0 = time();

for y=1:h, x=1:w
    c = complex((x-w/2)/(w/2), (y-h/2)/(w/2))
    m[y,x] = juliaset(c, c0, 256)
end

t1 = time();
   
create_pgmfile(m, pgm_name);

print("Записан $pgm_name\nВыполнено за $(t1-t0) сек.\n");