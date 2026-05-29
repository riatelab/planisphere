#' Project geographic data using a D3.js projection
#'
#' @description
#' Projects spatial data using D3.js geographic projections executed in a V8 JavaScript context.
#' The projection is performed in spherical coordinates, following D3.js design principles,
#' where the Earth is modeled as a sphere rather than an ellipsoid.
#'
#' @details
#' D3 geographic projections are based on spherical geometry. All transformations assume a
#' perfect sphere, which differs from traditional GIS pipelines that often rely on ellipsoidal
#' datums (e.g., WGS84). As a result, this function is primarily intended for visualization
#' and cartographic rendering rather than high-precision geodetic computation.
#'
#' @param ct A V8 JavaScript context created with \code{init()}.
#' @param x An \code{sf} spatial dataframe to project.
#' @param proj A D3 projection name or constructor (e.g. "geoInterruptedHomolosine").
#' @param rotate Rotation parameters passed to the projection.
#' @param reflectX Logical; whether to reflect the projection on the X axis.
#' @param reflectY Logical; whether to reflect the projection on the Y axis.
#' @param scale Projection scale factor (D3 spherical scale, not planar CRS units).
#' @param center Optional projection center.
#' @param reverse If TRUE, flips the Y axis for display consistency in R plots.
#' @param clipOutline If TRUE, clips the projected geometries to the projected sphere.
#' @param graticule Numeric vector of longitude/latitude step size for graticule generation.
#' @param ... Additional parameters passed to the projection builder.
#'
#' @return
#' A list of three \code{sf} objects:
#' \itemize{
#'   \item \code{basemap}: projected input geometries
#'   \item \code{sphere}: outline of the projected globe
#'   \item \code{graticule}: projected graticule lines
#' }
#'
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
#'
#'@seealso \code{\link{init}}
#'
#' @export
project <- function(
    ct,
    x,
    proj = "geoInterruptedHomolosine",
    rotate = NULL,
    reflectX = NULL,
    reflectY = NULL,
    scale = 6378137,
    center = NULL,
    reverse = TRUE,
    clipOutline = TRUE,
    graticule = c(10,10),
    ...
) {
  
  geojson <- geojsonsf::sf_geojson(x)
  
  # build projection chain in R (single source of truth)
  proj_chain <- build_projection_chain(
    proj = proj,
    rotate = rotate,
    reflectX = reflectX,
    scale = scale,
    center = center,
    ...
  )
  
  ct$assign("geojson", geojson)
  ct$assign("proj_chain", proj_chain)
  ct$assign("graticule_step", graticule)
  
  js <- "
  function project(geojson, proj_chain) {
    const geo = JSON.parse(geojson);
    const proj = eval(proj_chain);
    const basemap = d3.geoProject(geo, proj);
    const sphere = d3.geoProject({ type: 'Sphere' }, proj);
    const graticule = d3.geoProject(d3.geoGraticule().step(graticule_step)(), proj)
    return {
      sphere: JSON.stringify(sphere),
      graticule: JSON.stringify(graticule),
      basemap: JSON.stringify(basemap)
    }
  }
  "
  
  ct$eval(js)
  
  res <- ct$call(
    "project",
    geojson,
    proj_chain,
    await = FALSE
  )
  
  # Retreive geometries
  
  basemap <- geojsonsf::geojson_sf(res$basemap)
  sphere <- geojsonsf::geojson_sf(res$sphere)
  graticule <- geojsonsf::geojson_sf(res$graticule)
  
  sf::st_crs(basemap) <- NA
  sf::st_crs(sphere) <- NA
  sf::st_crs(graticule) <- NA
  
  # post-processing
  
  basemap <- st_make_valid(basemap)
  graticule <- st_make_valid(graticule)
  sphere <- st_make_valid(sphere)
  
  if (reverse) {
    basemap <- flipY(basemap)
    sphere <- flipY(sphere)
    graticule <- flipY(graticule)
  }
  
  
  if (clipOutline) {
    basemap <- st_intersection(basemap, sphere)
    graticule <- st_intersection(graticule, sphere)
  }
  
  
  
  
  return(list(
    basemap = basemap,
    sphere = sphere,
    graticule = graticule
  ))
}