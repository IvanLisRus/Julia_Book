#
# aapl_stats.jl
#

cd(joinpath(homedir(), "julia_projects","data"))

using DataFrames, StatsBase

aapl = readtable("AAPL_Short.csv")

naapl = size(aapl)[1]
m1 = round(Int,mean((aapl[:Volume])))   # => 6306547 

using Match

wts = zeros(naapl);

for i in 1:naapl
    dt = aapl[:Date][i]
    wts[i] = @match dt begin
         r"^2000" => 1.0
         r"^2001" => 2.0
         r"^2002" => 4.0
         _        => 0.0
    end
end

wv = WeightVec(wts);
m2 = int(mean(aapl[:Volume], wv)) 
mean(aapl[:Close])
mean(aapl[:Close], wv)
trimmean(aapl[:Close], 0.1)

std(aapl[:Close])
skewness(aapl[:Close])
kurtosis(aapl[:Close])       
