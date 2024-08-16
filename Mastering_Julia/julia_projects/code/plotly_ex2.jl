using Plotly

# Войти в систему под своим именем пользователя и со своим api-ключом
Plotly.signin("myuserid", "abc32def7g")


N = 100;
x = linspace(-2*pi, 2*pi, N);
y = linspace(-2*pi, 2*pi, N);
z = rand(N, N);

for i = 1:N, j = 1:N
  r2 = (x[i]^2 + y[j]^2);
  z[i,j] = sin(x[i]) * cos(y[j]) * sin(r2)/log(r2+1);
end

data = [ Dict("z" => z,"x" => x,"y" => y,"type" => "contour") ];

response = Plotly.plot(data,
  Dict("filename" => "simple-contour",
       "fileopt"  => "overwrite"));

plot_url = response["url"];

Plotly.openurl(plot_url) # Показать график, выложенный по адресу URL http://plot.ly/~myuserid/идентификатор