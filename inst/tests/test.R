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

planisphere::registry(type = "polyhedral")


test <- planisphere::project(
  x = world,
  "geoCox",
  verbose=TRUE,
  additional_layers = TRUE
)

planisphere::display(test)

fod
test <- planisphere::project(
  x = world,
  proj = "Airocean",
  additional_layers = TRUE,
  clip = TRUE
)
planisphere::display(test)



     

hao <- planisphere::project(
  x = world,
  proj = "geoHufnagel",
  a = 0.8,
  b = 0.35,
  psiMax = 50,
  ratio = 1.6,
  angle = 90,
  rotate = c(110, -200, 90),
  additional_layers = TRUE
)
planisphere::display(hao)


toto <- planisphere::project(x = world, scale = 500, proj = "geoAirocean", additional_layers = T)
planisphere::display(toto)

Nat <- planisphere::project(
  x = world,
  proj = "NaturalEarth1",
scale = 500,
  additional_layers = TRUE
)

Nat$sphere
planisphere::display(Nat)


# Overview

gallery <- function(world,
                             projections,
                             ncol = 4,
                             additional_layers = TRUE,
                             title_prefix = NULL) {
  
  n <- length(projections)
  
  op <- par(mfrow = c(ceiling(n / ncol), ncol),
            mar = c(1, 1, 2, 1))
  on.exit(par(op), add = TRUE)
  
  for (i in seq_along(projections)) {
    
    proj <- projections[i]
    
    cat("Rendering:", proj, "\n")
    
    p <- tryCatch(
      planisphere::project(
        x = world,
        proj = proj,
        additional_layers = additional_layers
      ),
      error = function(e) {
        message("Failed: ", proj)
        return(NULL)
      }
    )
    
    if (is.null(p)) next
    
    title <- if (!is.null(title_prefix)) {
      paste0(title_prefix, proj)
    } else {
      proj
    }
    
    planisphere::display(p, title = title)
  }
}

projections <- planisphere::registry(type = "core")

gallery(world, projections = projections, ncol = 6)

test <- planisphere::project(world, proj = "ConicConformal", clip = T, additional_layers = T)
planisphere::display(test$graticule)

toto <- planisphere::project(x = world, proj = "Spilhaus", additional_layers = T)
planisphere::display(toto)
