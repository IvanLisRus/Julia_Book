#
# mcmc_dogs.jl
#
# Имитационное моделирование по схеме MCMC

cd(joinpath(homedir(),"julia_projects","data"))

using Mamba, Distributions

dogs = (Symbol => Any)[:Y => round(Int, readdlm("dogs.wsv")) ]

dogs[:Dogs] = size(dogs[:Y], 1)
dogs[:Trials] = size(dogs[:Y], 2)

dogs[:xa] = mapslices(cumsum, dogs[:Y], 2)
dogs[:xs] = mapslices(x -> collect(1:25) - x, dogs[:xa], 2)
dogs[:y] = 1 - dogs[:Y][:, 2:25]


## Спецификация модели
model = Model(

  y = Stochastic(2,
    (Dogs, Trials, alpha, xa, beta, xs) ->
      UnivariateDistribution[
        begin
          p = exp(alpha * xa[i, j] + beta * xs[i, j])
          Bernoulli(p)
        end
        for i in 1:Dogs, j in 1:Trials-1
      ],
    false
  ),

  alpha = Stochastic(
    () -> Truncated(Flat(), -Inf, -1e-5)
  ),

  A = Logical(
    alpha -> exp(alpha)
  ),

  beta = Stochastic(
    () -> Truncated(Flat(), -Inf, -1e-5)
  ),

  B = Logical(
    beta -> exp(beta)
  )

)


## Начальные значения
inits = [
  Dict(:y => dogs[:y], :alpha => -1, :beta => -1),
  Dict(:y => dogs[:y], :alpha => -2, :beta => -2)
]


## План выборки (взятия проб)
scheme = [Slice([:alpha, :beta], 1.0)]
setsamplers!(model, scheme)


## Имитационный прогон по MCMC
sim = mcmc(model, dogs, inits, 10000, burnin=2500, thin=2, chains=2)

describe(sim)
