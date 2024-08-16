#
# kdensity1.jl
#

cd(joinpath(homedir(), "julia_projects","data"))

using RDatasets, KernelDensity

mlmf = dataset("mlmRev", "Gcsemv");

df = mlmf[complete_cases(mlmf[[:Written, :Course]]), :]

dc = convert(Array, df[:Course]);
dcc = zeros(0);
for i in 1:length(dc)
  if !isnan(dc[i])
    push!(dcc,dc[i])
  end
end
kdc = kde(dcc)

dw = convert(Array, df[:Written]);
dww = zeros(0);
for i in 1:length(dw)
  if !isnan(dw[i])
    push!(dww,dw[i])
  end
end
kdw = kde(dww)


using Winston

kdc = kde(dcc); kdw = kde(dww);

p = Winston.plot(kdc.x, kdc.density, "r--", kdw.x, kdw.density, "b;")
add(p, PlotLabel(.25, .87, "Письменный экзамен", color=0x0))
add(p, PlotLabel(.75, .87, "Курсовая", color=0x0))