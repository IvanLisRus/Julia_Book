#
# gaston_ex2.jl
#
# График будет показан в отдельном окне

# выделенная часть кода может устареть
# когда/если автор пакета выполнит его обновление
# с учетом последних версий языка и утилиты gnuplot
cd(joinpath(homedir(),"julia_projects","gaston","src"))
include("Gaston.jl")
#

using Gaston
g = Gaston;

c = g.CurveConf();
c.plotstyle = "pm3d";
x = -15:0.33:15;
y = -15:0.33:15;
Z = g.meshgrid(x, y, (x,y) -> 
                    sin(sqrt(x .* x+y .* y)) / sqrt(x .* x+y .* y));

g.addcoords(x,y,Z,c);
a = g.AxesConf();
a.title = "3D: Сомбреро";
g.addconf(a);
g.llplot()