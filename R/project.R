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
#' @param x An \code{sf} spatial dataframe to project.
#' @param proj A D3 projection name or constructor (e.g. "geoInterruptedHomolosine").
#' @param rotate Rotation parameters passed to the projection.
#' @param reflectX Logical; whether to reflect the projection on the X axis.
#' @param reflectY Logical; whether to reflect the projection on the Y axis.
#' @param scale Projection scale factor (D3 spherical scale, not planar CRS units).
#' @param center Optional projection center.
#' @param parallels Optional standard parallels of the projection
#' @param parallel Optional standard parallel of the projection
#' @param clip If TRUE, clips the projected geometries to the projected sphere.
#' @param graticule Numeric vector of longitude/latitude step size for graticule generation.
#' @param additional_ayers Logical. If TRUE, adds graticule and sphere layers. In this case, the function returns a list. If FALSE (default), it returns a spatial data frame.
#' @param ct A custom V8 JavaScript context if needed. See \code{new_v8_context()}.
#' @param ... Additional parameters passed to the projection builder.
#'
#' @return
#' If \code{additionalLayers = FALSE}, a single \code{sf} object corresponding to the projected basemap.
#'
#' If \code{additionalLayers = TRUE}, a list of \code{sf} objects:
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
#' result <- planisphere::project(x = world, proj = "InterruptedBoggs")
#'
#' @export
project <- function(
  x,
  proj = "geoAzimuthalEqualArea",
  rotate = NULL,
  reflectX = NULL,
  reflectY = NULL,
  scale = 500,
  center = NULL,
  parallel = NULL,
  parallels = NULL,
  clipExtent = NULL,
  clip = TRUE,
  graticule = c(10, 10),
  additional_layers = FALSE,
  verbose = FALSE,
  ct = .planisphere$ct,
  ...
) {
  # post-processing
  if (clip) {
    geojson <- geojsonsf::sf_geojson(clean(x))
  } else {
    geojson <- geojsonsf::sf_geojson(x)
  }


  # build projection chain in R
  proj_chain <- build_projection_chain(
    proj = proj,
    rotate = rotate,
    reflectX = reflectX,
    reflectY = reflectY,
    scale = scale,
    center = center,
    parallel = parallel,
    parallels = parallels,
    clipExtent = clipExtent,
    verbose = verbose,
    ...
  )


  # JS operations
  ct$assign("geojson", geojson)
  ct$assign("proj_chain", proj_chain)
  ct$assign("graticule_step", graticule)
  ct$assign("clip", clip && !grepl("orthographic", proj, ignore.case = TRUE))

  js <- "
  function project(geojson, proj_chain) {
    const geo = JSON.parse(geojson);
    const proj = eval(proj_chain);
    const basemap = d3.geoProject(geo, proj);
    const sphereRaw = d3.geoProject({ type: 'Sphere' }, proj);
    const sphere = clip ? shrinkGeometry(sphereRaw, 0.99) : sphereRaw
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
  # special fix for orthographic projection

  if (!grepl("orthographic", proj, ignore.case = TRUE)) {
    basemap <- sf::st_make_valid(basemap)
    graticule <- sf::st_make_valid(graticule)
    sphere <- sf::st_make_valid(sphere)
  }

  basemap <- flipY(basemap)
  sphere <- flipY(sphere)
  graticule <- flipY(graticule)

  if (clip && !grepl("orthographic", proj, ignore.case = TRUE)) {
    basemap <- sf::st_intersection(basemap, sphere)
    graticule <- sf::st_intersection(graticule, sphere)
  }


  if (!additional_layers) {
    return(basemap)
  } else {
    return(list(
      basemap = basemap,
      sphere = sphere,
      graticule = graticule
    ))
  }
}