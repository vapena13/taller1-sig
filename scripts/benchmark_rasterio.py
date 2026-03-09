import rasterio
import numpy as np
import time
import gc

with open("/home/rstudio/work/taller1-sig/data/s2_shared_path.txt", "r") as f:
    s2_path = f.read().strip()

# warm-up
with rasterio.open(s2_path) as src:
    _ = (src.read(1) * 1.5).mean()

gc.collect()

t0 = time.perf_counter()

with rasterio.open(s2_path) as src:
    band = src.read(1)
    res = band * 1.5
    m_py = res.mean()

t_python = time.perf_counter() - t0

print(f"rasterio: {t_python:.3f} seg | mean = {m_py:.6f}")