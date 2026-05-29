#' @title Display a projected planisphere
#'
#' @description
#' Render a complete planisphere from a projected object created with \code{project()}.
#' The display includes the projected sphere outline, graticule, and geographic features.
#'
#' @details
#' The visualization follows the D3.js spherical projection model used in the package.
#' The rendering order is:
#' 1. Sphere background
#' 2. Graticule
#' 3. Projected landmass (basemap)
#' 4. Sphere outline
#'
#' All geometries are expected to be already projected in spherical coordinates.
#' This function is intended for fast visualization and exploration of D3-based projections.
#'
#' @param result A list returned by \code{project()}, containing three \code{sf} objects:
#' \itemize{
#'   \item \code{basemap}: projected geographic features
#'   \item \code{sphere}: outline of the projected globe
#'   \item \code{graticule}: projected latitude/longitude grid
#' }
#'
#' @return a base R plot.
#'
#' @seealso \code{\link{project}}, \code{\link{init}}
#'
#' @export
#'
#' @examples
#' library(sf)
#' world <- st_read(
#'   system.file("gpkg/land.gpkg", package = "planisphere"),
#'   quiet = TRUE
#' )
#'
#' ct <- planisphere::init()
#' result <- planisphere::project(ct, x = world, proj = "geoInterruptedBoggs")
#' planisphere::display(result)
display <- function(result) {
  
  op <- par(
    mar = c(0, 0, 0, 0),   
    bg = "white"
  )
  
  on.exit(par(op))
  
  plot(sf::st_geometry(result$sphere),
       col = "#F5F5F5",
       border = NA)
  
  plot(sf::st_geometry(result$graticule),
       col = "#D0D0D0",
       lwd = 0.5,
       add = TRUE)
  
  plot(sf::st_geometry(result$basemap),
       col = "#222222",
       border = NA,
       add = TRUE)

  plot(sf::st_geometry(result$sphere),
       col = NA,
       border = "#666666",
       lwd = 1.2,
       add = TRUE)
}