#
# xkcd_graph.jl
#

using PyPlot

xkcd()

fig = figure(figsize=(10,5))

ax = axes()

p = plot(x,sin(3x + cos(5x)))

ax[:set_xlim]([0.0,6])
annotate("Несколько\nсхематичный",xy=[0.98,.001],
arrowprops=["arrowstyle"=>"->"],xytext=[1.3,-0.3])
xticks([])
yticks([])
xlabel("ВРЕМЯ")
ylabel("ПРОИЗВОДИТЕЛЬНОСТЬ")
title("График в стиле веб-комикса xkcd в Julia")
ax[:spines]["top"][:set_color]("none")
ax[:spines]["right"][:set_color]("none")

