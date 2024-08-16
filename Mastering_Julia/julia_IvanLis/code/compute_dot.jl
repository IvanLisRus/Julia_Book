#
# compute_dot.jl
#
# Вызов программы на Fortran
# для Unix-подобных OC

function compute_dot(DX::Vector{Float64}, DY::Vector{Float64})
  assert(length(DX) == length(DY))
  n = length(DX)
  incx = incy = 1
  product = ccall((:ddot_, "/usr/lib/lapack/liblapack.so.3.6.0"),
                   Float64,
                   (Ptr{Int32}, Ptr{Float64}, Ptr{Int32}, Ptr{Float64}, Ptr{Int32}),
                   &n, DX, &incx, DY, &incy)
  return product
end
