library(terra)

s2_path <- readLines("/home/rstudio/work/taller1-sig/data/s2_shared_path.txt")

# warm-up
r0 <- rast(s2_path)
tmp0 <- global(r0[[1]] * 1.5, "mean", na.rm = TRUE)

gc()

t0 <- Sys.time()

r <- rast(s2_path)
res <- r[[1]] * 1.5
m_terra <- global(res, "mean", na.rm = TRUE)[1, 1]

t1 <- Sys.time()
t_terra <- as.numeric(difftime(t1, t0, units = "secs"))

cat(sprintf("terra: %.3f seg | mean = %.6f\n", t_terra, m_terra))