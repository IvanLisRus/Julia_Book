#
# cl_gpu_calc.jl
#

import OpenCL

const cl = OpenCL
const kernel_source = """
  __kernel void mmul(
  const int Mdim, const int Ndim, const int Pdim,
  __global float* A, __global float* B, __global float* C) {
    int k;
    int i = get_global_id(0);
    int j = get_global_id(1);
    float tmp;
    if ((i < Ndim) && (j < Mdim)) {
      tmp = 0.0f;
      for (k = 0; k < Pdim; k++)
        tmp += A[i*Ndim + k] * B[k*Pdim + j];
        C[i*Ndim+j] = tmp;
    }
  }
"""

const ORDER = 1024; # Порядок квадратных матриц A, B и C
const TOL = 0.001;  # Точность (tolerance) вычислений с плавающей тчк
const COUNT = 3;    # Число прогонов

Ndims = 1024
sizeN = ORDER * ORDER;
h_A = float32(randn(ORDER)); # Заполнить массив случайными числами
h_B = float32(randn(ORDER)); # --- то же самое --
h_C = Array(Float32, ORDER); # Массив результатов

ctx = cl.Context(cl.devices()[2]);
queue = cl.CmdQueue(ctx, :profile);

d_a = cl.Buffer(Float32, ctx, (:r,:copy), hostbuf = h_A);
d_b = cl.Buffer(Float32, ctx, (:r,:copy), hostbuf = h_B);
d_c = cl.Buffer(Float32, ctx, :w, length(h_C));

prg = cl.Program(ctx, source=kernel_source) |> cl.build!
mmul = cl.Kernel(prg, "mmul");

for i in 1:COUNT
  fill!(h_C, 0.0);
    
  global_range = (ORDER, ORDER);
  mmul_ocl = mmul[queue, global_range];
  evt = mmul_ocl(Int32(ORDER), Int32(ORDER), Int32(ORDER), d_a, d_b, d_c);
  run_time = evt[:profile_duration] / 1e9;
  cl.copy!(queue, h_C, d_c);
    
  mflops = 2.0 * Ndims^3 / (1000000.0 * run_time);
    
  @printf "%10.8f сек. за %9.5f мегафлопс\n" run_time mflops
end