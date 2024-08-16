#
# winston_graph.jl
#

cd(joinpath(homedir(),"julia_projects","images"))

using Winston

p = FramedPlot(aspect_ratio=1,xrange=(0,100),yrange=(0,100));
n = 21;
x = linspace(0, 100, n);

# Создать множество случайных величин
yA = 40 .+ 10*randn(n);
yB = x .+ 5*randn(n);

# Установить метки и стили символов
a = Points(x, yA, kind="circle");
setattr(a,label="точки a");

b = Points(x, yB);
setattr(b,label=" точки b");
style(b, kind="filled circle");

# Начертить линию, которая "оптимально пролегает" через точки yB 
# и добавить легенду в верхнюю левую часть графика
s = Slope(1, (0,0), kind="dotted");
setattr(s, label="наклонная");

lg = Legend(.1, .9, {a,b,s});
add(p, s, a, b, lg);
display(p)

savefig(p, "figure_7_4.png")