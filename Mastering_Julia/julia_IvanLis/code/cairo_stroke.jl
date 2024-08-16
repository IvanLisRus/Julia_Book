#
# cairo_stroke.jl
#

cd(joinpath(homedir(),"julia_projects","images"))

using Cairo

c = CairoRGBSurface(512, 128);
cr = CairoContext(c);
save(cr);
set_source_rgb(cr, 0.8, 0.8, 0.8);     # светло-серый
rectangle(cr, 0.0, 0.0, 512.0, 128.0); # фон
fill(cr);
restore(cr);
save(cr);

x0=51.2; y0=64.0;
x1=204.8; y1=115.4;
x2=307.2; y2=12.8;
x3=460.8; y3=64.0;
move_to (cr, x0, y0);
curve_to (cr, x1, y1, x2, y2, x3, y3);
set_line_width (cr, 10.0);
stroke (cr);
restore(cr);

move_to(cr, 12.0, 12.0);
set_source_rgb (cr, 0, 0, 0);

show_text(cr,"Figure 7-2")
write_to_png(c,"figure_7_2_stroke.png");
