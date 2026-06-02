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


x <- planisphere::project(x = world, proj = "geoAirocean", additional_layers = TRUE)
planisphere::display(x, title ="Hello")


library(sf)

x <- st_make_valid(x$sphere)


plot(st_geometry(x), col = "blue", border = NA)


x <- planisphere::project(x = world, proj = "geoSatellite", additional_layers = T, verbose = TRUE)
planisphere::display(x, title = "coucouc")


