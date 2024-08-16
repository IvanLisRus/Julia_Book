"""
    Wrapper for primesieves library
    Copyright 2016 Scott Paul Jones
    MIT Licensed
"""
module PrimeSieves

# Решето Эратосфена – это алгоритм нахождения простых чисел до заданного числа n

export PrimeSieveIterator, skipto, next, previous, free

const global psilib = "libprimesieve.dylib"

type PrimeSieveIterator
    i::Csize_t
    last_idx::Csize_t
    primes::Ptr{UInt64}
    primes_pimpl::Ptr{UInt64}
    start::UInt64
    stop::UInt64
    stop_hint::UInt64
    tiny_cache_size::UInt64
    is_error::Cint
    function PrimeSieveIterator()
        piter = new(0,0,C_NULL,C_NULL,0,0,0,0,0)
        ccall((:primesieve_init, psilib), Void, (Ref{PrimeSieveIterator},), piter)
        finalizer(piter, free)
        piter
    end
end

""" Free all memory """
function free(piter::PrimeSieveIterator)
    # Make sure it isn't freed twice
    if piter.primes != C_NULL
        ccall((:primesieve_free_iterator, psilib), Void, (Ref{PrimeSieveIterator},), piter)
        piter.primes = C_NULL
        piter.primes_pimpl = C_NULL
    end
    nothing
end
""" Set the primesieve iterator to start """
skipto(piter::PrimeSieveIterator, start::Integer, stop_hint::Integer) =
    ccall((:primesieve_skipto, psilib), Void,
          (Ref{PrimeSieveIterator}, UInt64, UInt64), piter, start, stop_hint)

""" Get the next prime """
function Base.next(piter::PrimeSieveIterator)
    (piter.i-1) >= piter.last_idx &&
        ccall((:primesieve_generate_next_primes, psilib), Void, (Ref{PrimeSieveIterator},), piter)
    unsafe_load(piter.primes, piter.i += 1)
end

""" Get the previous prime """
function previous(piter::PrimeSieveIterator)
    if piter.i == 0
        ccall((:primesieve_generate_previous_primes, psilib),
              Void, (Ref{PrimeSieveIterator},), piter)
    else
        piter.i -= 1
    end
    unsafe_load(piter.primes, piter.i + 1)
end

end