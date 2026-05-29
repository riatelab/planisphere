#' @title Initialize D3.js projection system
#'
#' @description
#' Create a V8 JavaScript context and load the required D3.js libraries
#' to enable cartographic projections.
#'
#' @details
#' This function initializes a V8 JavaScript runtime and loads the D3.js
#' geospatial ecosystem used by the package, including:
#' - d3 (core library)
#' - d3-geo (spherical geometry and projections)
#' - d3-geo-projection (extended map projections)
#' - d3-geo-polygon (polygon clipping on the sphere)
#'
#' Libraries are loaded from jsDelivr CDN by default, but local or custom URLs
#' can be provided.
#'
#' All projections in this package are computed using D3.js spherical geometry,
#' where the Earth is modeled as a sphere rather than an ellipsoid.
#'
#' @param libs Character vector of JavaScript library URLs to load.
#' By default, libraries are loaded from the jsDelivr CDN, but URLs may be
#' replaced with local files or alternative CDNs.
#'
#' @param verbose Logical. If TRUE, prints the status of each loaded library
#' in the console.
#'
#' @return
#' A V8 JavaScript context with all specified libraries loaded.
#'
#' @export
#'
#' @examples
#' ct <- planisphere::init()
init <- function(
    libs = c(
      "https://cdn.jsdelivr.net/npm/d3@7",
      "https://cdn.jsdelivr.net/npm/d3-geo@3",
      "https://cdn.jsdelivr.net/npm/d3-geo-projection@4",
      "https://cdn.jsdelivr.net/npm/d3-geo-polygon@1"
    ),
    verbose = TRUE
) {
  
  ct <- V8::v8()
  
  if (verbose) message("Loading JavaScript libraries")
  
  for (l in libs) {
    
    status <- tryCatch({
      
      suppressWarnings(
        suppressMessages(
          ct$source(l)
        )
      )
      
      "✔"
      
    }, error = function(e) {
      "✖"
    })
    
    if (verbose) {
      message(sprintf("%s %s", status, l))
    }
  }
  
  ct
}