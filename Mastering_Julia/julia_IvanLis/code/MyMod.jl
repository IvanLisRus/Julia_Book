#
# MyMod.jl
#

module MyMod

export hi, inc, fac, fib, pisq;

hi() = "Привет"
hi(who::AbstractString) = "Привет, $who"

inc(x::Number) = x + 1

function fac(n::Integer)
  @assert n > 0
  (n == 1) ? 1 : n*fac(n-1);
end

function fib_helper(a ::Integer, b::Integer, n::Integer)
   (n > 0) ? fib_helper(b, a+b, n-1) : a
end

function fib(n::Integer)
   @assert n > 0
   fib_helper(0, 1, n)
end

function pisq(n::Integer)
  (n <= 0) ? error("Нулевой или отрицательный аргумент") : begin
    s = 1.0
    for k = 1:n
      s += (-1.0)^k/(1.0 + k)^2
    end
    return 12*s
  end
end

end