#
# winston_graph.jl
#

cd(joinpath(homedir(),"julia_projects","images"))

using Winston

p = FramedPlot(aspect_ratio=1,xrange=(0,100),yrange=(0,100));
n = 21;
x = linspace(0, 100, n);

# ������� ��������� ��������� �������
yA = 40 .+ 10*randn(n);
yB = x .+ 5*randn(n);

# ���������� ����� � ����� ��������
a = Points(x, yA, kind="circle");
setattr(a,label="����� a");

b = Points(x, yB);
setattr(b,label=" ����� b");
style(b, kind="filled circle");

# ��������� �����, ������� "���������� ���������" ����� ����� yB 
# � �������� ������� � ������� ����� ����� �������
s = Slope(1, (0,0), kind="dotted");
setattr(s, label="���������");

lg = Legend(.1, .9, {a,b,s});
add(p, s, a, b, lg);
display(p)

savefig(p, "figure_7_4.png")