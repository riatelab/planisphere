pkgdown::build_site()
library(sf)
world <- st_read(
  system.file("gpkg/world.gpkg", package = "planisphere"),
  quiet = TRUE
)
detach("package:planisphere", unload = TRUE, character.only = TRUE)
.rs.restartR()
devtools::load_all()
library(planisphere)

getwd()





shift_geom <- function(x, dx = 0, dy = 0) {
  st_geometry(x) <- st_geometry(x) + c(dx, dy)
  x
}

make_square <- function(x, y, size) {
  
  x0 <- x - size / 2
  x1 <- x + size / 2
  y0 <- y - size / 2
  y1 <- y + size / 2
  
  coords <- rbind(
    c(x0, y0),
    c(x1, y0),
    c(x1, y1),
    c(x0, y1),
    c(x0, y0)  
  )
  
  st_sfc(
    st_polygon(list(coords)),
    crs = NA_crs_
  )
}


sf_merge_dissolve <- function(...) {
  
  x <- do.call(rbind, list(...))
  
  attrs <- st_drop_geometry(x)
  
  key <- apply(attrs, 1, function(r) {
    paste(ifelse(is.na(r), "NA", r), collapse = "||")
  })
  
  groups <- split(seq_len(nrow(x)), key)
  
  geom <- lapply(groups, function(i) {
    st_sfc(st_union(x[i, ]))
  })
  
  geom <- do.call(c, geom)   # <-- IMPORTANT : garantit un sfc valide
  
  attrs_out <- attrs[vapply(groups, `[`, integer(1), 1), , drop = FALSE]
  
  st_sf(attrs_out, geometry = geom)
}

geoAirocean <- planisphere::project(x = world, proj = "geoAirocean", additional_layers = TRUE)

planisphere::display(geoAirocean)

plot(st_geometry(geoAirocean$basemap), col = "red")


peirceN <- planisphere::project(x = world, proj = "d3.geoPeirceQuincuncial().rotate([-25, -90])", additional_layers = TRUE)
peirceS <- planisphere::project(x = world, proj = "d3.geoPeirceQuincuncial().rotate([-25, 90, 180])", additional_layers = TRUE)

bb <- st_bbox(peirce$sphere)
width <- bb$xmax-bb$xmin
height <- bb$ymax-bb$ymin

peirce1 <- peirceN$basemap
peirce2 <- shift_geom(peirceS$basemap, -width/2, -height/2)
peirce3 <- shift_geom(peirceS$basemap, width/2, height/2)


square1 <- make_square(x = bb$xmin, y = bb$ymin, size = width/5.5)
square2 <- make_square(x = bb$xmax - width/5.5, y = bb$ymax, size = width/5.5)
square3 <- make_square(x = bb$xmin, y = bb$ymax, size = width/2)
square4 <- make_square(x = bb$xmax, y = bb$ymax, size = width/5.5)
square5 <- make_square(x = bb$xmax, y = bb$ymin, size = width/5.5)

extent <- st_union(peirceN$sphere, square1)
extent <- st_union(extent, square2)
extent <- st_difference(extent, square3)
extent <- st_difference(extent, square4)
extent <- st_difference(extent, square5)

x <- sf_merge_dissolve(peirce1, peirce2, peirce3)

plot(st_geometry(x), col = "#CCC", border = NA)
plot(st_geometry(extent), col = NA, border = "black", add=T)

result <- st_intersection(x, extent)
plot(st_geometry(result))
plot(st_geometry(extent), add=T, col = NA)


planisphere::display(peirce, title ="Hello")


x <- tmp$sphere
hull <- st_convex_hull(x)
x <- st_make_valid(st_union(st_difference(hull, st_buffer(x,10))))

plot(st_geometry(), col = "red")


x <- planisphere::project(x = world, proj = "geoEqualEarth", reflectX = TRUE, verbose = T)
planisphere::display(x, title ="Hello")

library(sf)

x <- st_make_valid(x$sphere)


plot(st_geometry(x), col = "blue", border = NA)


x <- planisphere::project(x = world, proj = "geoSatellite", additional_layers = T, verbose = TRUE)
planisphere::display(x, title = "coucouc")


