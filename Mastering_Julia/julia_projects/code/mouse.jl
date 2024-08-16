# http://en.wikipedia.org/wiki/Stochastic_matrix

cd(joinpath(homedir(), "julia_projects","data"))

I = zeros(4,4);
[I[i,i] = 1 for i in 1:4];

f = open("mouse_data.txt","r")
T = readdlm(f,',');
close(f);

Ep = [0 1 0 0]*inv(I - T)*[1,1,1,1];

println("Ожидаемое время жизни мышки равно $Ep")