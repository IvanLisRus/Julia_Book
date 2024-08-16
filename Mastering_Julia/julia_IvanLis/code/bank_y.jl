#
# bank_y.jl
#

using SimJulia
using Distributions

function customer(env::Environment, name::UTF8String, counter::Resource, time_in_bank::Float64)
  arrive = now(env)
    
  println("$arrive $name: прибыл")
    
  req = Request(counter)
  patience = rand(Uniform(MIN_PATIENCE, MAX_PATIENCE))
  result = yield(req | Timeout(env, patience))
    
  wait = now(env) - arrive
  push!(wait_times, wait);
    
  if in(req, keys(result))
    println("$(now(env)) $name: прождал $wait") 
    yield(Timeout(env, rand(Exponential(time_in_bank))))
    println("$(now(env)) $name: обслужен")    
    yield(Release(counter))
    #push!(in_bank_times, now(env) - arrive);
  else
    println("$(now(env)) $name: ОТКАЗАЛСЯ после $wait")
    push!(renege_qty, 1);       
    SimJulia.cancel(req)
  end
end

function source(env::Environment, number::Int, interval::Float64, counter::Resource)
  d = Exponential(interval)
  for i in 1:number
    Process(env, customer, "Клиент №$i", counter, 12.0)
    yield(Timeout(env, rand(d)))
  end
end

function randomize()  # lcg_rand
  seed = ccall( (:GetTickCount, "kernel32"), stdcall, Int32, () );
  ((seed * 214013 + 2531011) >> 16) & 0x7fff
end

# Настроить и запустить имитационный прогон
println("Отказы от услуги в банке\n")

# Установить исходные данные имитации 

const MAX_CUSTOMERS     = 20    # Общее число клиентов
const MAX_TIME          = 400.0 # Общее время работы банка
const MEAN_ARRIVAL_TIME = 10.0   # Генерировать новых клиентов с прим. промежутком x (интервалы)
const MIN_PATIENCE      = 2.0   # Минимальное терпение клиента
const MAX_PATIENCE      = 12.0   # Максимальное терпение клиента (среднее время обслуживания)
const MAX_TELLERS       = 1     # Число операционистов

# Использовать ранее определенную функцию randomize() либо 
# выбрать значение, чтобы сделать прогон воспроизводимым
#const RANDOM_SEED = 150  
const RANDOM_SEED = randomize()
srand(RANDOM_SEED)

global wait_times = Float64[];  # Времена ожидания
global renege_qty = Int32[];    # Количество отказов

env = Environment()

# Запустить процессы и выполнить
counters = Resource(env, MAX_TELLERS)
Process(env, source, MAX_CUSTOMERS, MEAN_ARRIVAL_TIME, counters)
run(env, MAX_TIME)

@printf "\nПри наличии %s операциониста(ов):\n" MAX_TELLERS
@printf "Среднее время ожидания = %5.3f\n" mean(wait_times)
@printf "Количество отказов = %5d" sum(renege_qty)
