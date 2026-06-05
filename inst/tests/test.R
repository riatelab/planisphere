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

prj <- "d3.geoConicConformal().clipExtent([[200, 0],[880, 400]])"

result <- planisphere::project(world, 
                               proj = prj, additional_layers = T)
planisphere::display(result)





europe <- sf::st_read("https://gisco-services.ec.europa.eu/distribution/v2/nuts/gpkg/NUTS_RG_20M_2024_4326_LEVL_0.gpkg") |>
 sf::st_crop(xmin=-10, xmax=45, ymin=25, ymax=72)

laea <- planisphere::project(europe, proj = "AzimuthalEqualArea", 
                             rotate = c(-10, -52))
planisphere::display(laea)

france <- europe[europe$ISO3_CODE == "FRA",]



lambert93 <- planisphere::project(france, 
                                 proj = "ConicConformal", 
                                 rotate = c(-3,0), 
                                 center = c(0, 46.5),
                                 parallels = c(44,49),
                                 clipExtent =  list(c(0, 0), c(1000, 1000))
                                 )

planisphere::display(laea)

planisphere::display(lambert93)

plot(st_geometry(europe))



