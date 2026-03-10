import Pkg
Pkg.add("Rasters")

using Rasters
using ArchGDAL
using Statistics

# leer ruta compartida
s2_path = strip(read("/home/rstudio/work/taller1-sig/data/s2_shared_path.txt", String))

# evitar restricciones de memoria
Rasters.checkmem!(false)

# función de benchmark
function process_band_mean(path)
    ArchGDAL.read(path) do ds
        r = Raster(ds)[Band(1)]
        res = r .* 1.5
        return mean(res)
    end
end

# warm-up
process_band_mean(s2_path)
GC.gc()

# benchmark real
t0 = time_ns()
m_julia = process_band_mean(s2_path)
t1 = time_ns()

t_julia = (t1 - t0) / 1e9

println("julia: $(round(t_julia, digits=3)) seg | mean = $(round(m_julia, digits=6))")