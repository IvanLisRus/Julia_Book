#
# kdensity2.jl
#

cd(joinpath(homedir(), "julia_projects","data")); 

using RDatasets, KernelDensity

# вспомогательная функция NaN -> NA
function nan2na(df)
    for c in eachcol(df)
        nans = find(x->isa(x,AbstractFloat) && isnan(x),c[2])
        df[nans,c[1]] = NA
    end
    df
end

mlmf = dataset("mlmRev","Gcsemv")
mlmf = @unix ? mlmf : nan2na(mlmf); # только для Windows

df = mlmf[complete_cases(mlmf[[:Written, :Course]]), :];

dc = convert(Array, df[:Course]); kdc = kde(dc);
dw = convert(Array, df[:Written]); kdw = kde(dw);

using Winston

kdc = kde(dc); kdw = kde(dw);
using Winston;
p = Winston.plot(kdc.x, kdc.density, "r--", kdw.x, kdw.density, "b;")
add(p, PlotLabel(.25, .87, "Письменный экзамен", color=0x0))
add(p, PlotLabel(.75, .87, "Курсовая", color=0x0))