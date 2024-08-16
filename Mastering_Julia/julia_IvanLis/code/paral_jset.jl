# 
# paral_jset.jl
#

function create_pgmfile(img, outf::AbstractString)
  s = open(outf, "w")
  write(s, "P5\n")
  n, m = size(img)
  write(s, "$m $n 255\n")
  for i=1:n, j=1:m
    p = img[i,j]
    write(s, p % UInt8)
  end
  close(s)
end

function para_jset(img)  
   yrange = img[1]  
   xrange = img[2]  
   array_slice = (size(yrange, 1), size(xrange, 1))  
   jset = Array(Int64, array_slice)   #UInt8
   x0 = xrange[1]  
   y0 = yrange[1]  

   for x = xrange, y = yrange  
     pix = 256
     z = complex( (x-width/2)/(height/2), (y-height/2)/(height/2)) 
     for n = 1:256
       if abs(z) > 2
         pix = n-1
         break
       end
       z = z^2 + C
     end
     jset[y - y0 + 1, x - x0 + 1] = pix   # Int64 !!
   end  
   return jset  
end

cd(joinpath(homedir(),"julia_projects","images"))

using Images

@everywhere using DistributedArrays

@everywhere width = 2000
@everywhere height = 1500
@everywhere C = -0.8 - 0.156im

dist_jset = DArray(para_jset, (height, width));
full_jset = convert(Array, dist_jset);
create_pgmfile(full_jset, "paral_jset.pgm");

