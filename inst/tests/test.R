pkgdown::build_site()
library(sf)
world <- st_read(
  system.file("gpkg/land.gpkg", package = "planisphere"),
  quiet = TRUE
)
detach("package:planisphere", unload = TRUE, character.only = TRUE)
.rs.restartR()
devtools::load_all()
library(planisphere)


planisphere::gallery(sample = NULL)
plot(world)
