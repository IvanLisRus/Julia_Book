using Plotly

using Plotly

# Войти в систему под своим именем пользователя и со своим api-ключом

Plotly.signin("myuserid", "abc32def7g")

trace1 = Dict(
  "x" => [0, 1, 2, 3, 4, 5, 6, 7, 8], 
  "y" => [8, 7, 6, 5, 4, 3, 2, 1, 0], 
  "type" => "scatter"
);

trace2 = Dict(
  "x" => [0, 1, 2, 3, 4, 5, 6, 7, 8], 
  "y" => [0, 1, 2, 3, 4, 5, 6, 7, 8], 
  "type" => "scatter"
);

data = [trace1, trace2];

layout = Dict(
  "xaxis" => Dict("type" => "log", "autorange" => true), 
  "yaxis" => Dict("type" => "log", "autorange" => true)
);

response = Plotly.plot(data, 
  Dict("layout"   => layout, 
       "filename" => "plotly-log-axes", 
       "fileopt"  => "overwrite"));

plot_url = response["url"]