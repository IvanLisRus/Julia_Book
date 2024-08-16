#
# low_fitsio.jl
#

using FITSIO
using FITSIO.Libcfitsio

# Низкоуровневый API размещен в подмодуле Libcfitsio

f001 = fits_open_file("f001a066.fits")
n = fits_get_hdrspace(f001)[1]; # => 128

for i = 1:n
   println(fits_read_keyn(f001,i))
end

