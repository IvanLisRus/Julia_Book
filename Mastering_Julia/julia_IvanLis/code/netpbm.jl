#
# netpbm.jl
#

#=
 if(intensity <= 0.25) {
  p->r = 0;
  p->g = 0;
  p->b = (intensity) * 4 * 255;
  return;
 }

 if(intensity <= 0.5) {
  p->r = 0;
  p->g = (intensity - 0.25) * 4 * 255;
  p->b = 255;
  return;
 }

 if(intensity <= 0.75) {
  p->r = 0;
  p->g = 255;
  p->b = (0.75 - intensity) * 4 * 255;
  return;
 }

 if(intensity <= 1.0) {
  p->r = (intensity - 0.75) * 4 * 255;
  p->g = (1.0 - intensity) * 4 * 255;
  p->b = 0;
  return;
 }
=#


function pseudocolor(pix::UInt8)
  if pix <= 64
    pr = UInt8(0)
    pg = UInt8(0)
    pb = UInt8(4)*pix
  elseif pix <= 128
    pr = UInt8(0)
    pg = UInt8(4)*(pix-UInt8(64))
    pb = UInt8(255)
  elseif pix <= 192
    pr = UInt8(0)
    pg = UInt8(255)
    pb = UInt8(0)   #UInt8(4*(192 - pix))
  else
    pr = UInt8(4)*(pix - UInt8(192))
    pg = UInt8(0)   #UInt8(4*(256 - pix))
    pb = UInt8(0)
  end
  return (pr, pg, pb)
end



img = open("images/juliaset.pgm");
magic = chomp(readline(img));   # => "P5"

if magic == "P5"
 out = open("images/jsetcolor.ppm", "w");
 println(out, "P6");
 
 params = chomp(readline(img));  # => "800 400 255"
 println(out, params);
 
 (wd, ht, pmax) = [parse(UInt64,v) for v in split(params)]
 
 for i = 1:ht
    buf = readbytes(img, wd);
    for j = 1:wd
      (r,g,b) = pseudocolor(buf[j]);
      write(out,r); write(out,g); write(out,b);
    end
 end
 
 close(out);
else
 error("Формат файла не является полутоновым NetPBM")
end

close(img);

