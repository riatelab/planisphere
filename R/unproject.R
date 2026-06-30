unproject <- function(
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
    verbose = FALSE,
    ct = .planisphere$ct,
    ...
) {

  x <- flipY(x)
  geojson <- geojsonsf::sf_geojson(x)

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

  js <- "
  function project(geojson, proj_chain) {
    const geo = JSON.parse(geojson);
    const proj = eval(proj_chain);
    const basemap = unproject(geo, {projection: proj});
    return JSON.stringify(basemap)
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
  
  basemap <- geojsonsf::geojson_sf(res)

  sf::st_crs(basemap) <- NA

    return(basemap)
}