
devtools::load_all()


library("sf")


world <- st_read(
  system.file("gpkg/world.gpkg", package = "planisphere"),
  quiet = TRUE
)
prj <- "Bertin1953"
prj <- "d3.geoPeirceQuincuncial().rotate([-25, -90])"
prj <- "InterruptedMollweide"

projected <- project(x = world, proj = prj)

projected <- projected[projected$ISO3 != "ATA",]

result <- unproject(projected,  prj)





plot(st_geometry(world))

plot(st_geometry(result), col="red", add=T)
