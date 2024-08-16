#
# gaston_ex1.jl
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
c.legend = "Произвольно";
c.plotstyle = "errorbars";
y = exp(-(1:.1:4.9));
ylow = y - 0.05*rand(40);
yhigh = y + 0.05*rand(40);
g.addcoords(1:40,y,c);
g.adderror(0.1*rand(40));
a = g.AxesConf();
a.title = "Значения ошибки (вертикальные отрезки)";
g.addconf(a);

g.llplot();  