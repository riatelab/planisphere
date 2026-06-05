#' @title New V8 context
#'
#' @description
#' Create a new V8 JavaScript context preloaded with the D3.js geospatial stack.
#'
#' @details
#' This function initializes a fresh V8 JavaScript runtime and automatically loads
#' the latest versions of the required D3.js libraries from the jsDelivr CDN.
#'
#' The following JavaScript libraries are loaded by default:
#'
#' - d3 (core library): https://cdn.jsdelivr.net/npm/d3@7
#' - d3-geo (spherical geometry and geographic projections): https://cdn.jsdelivr.net/npm/d3-geo@3
#' - d3-geo-projection (extended cartographic projections): https://cdn.jsdelivr.net/npm/d3-geo-projection@4
#' - d3-geo-polygon (spherical polygon clipping): https://cdn.jsdelivr.net/npm/d3-geo-polygon@1
#'
#' These libraries are fetched dynamically at runtime from the jsDelivr CDN,
#' ensuring that the most recent compatible versions are used unless explicitly
#' overridden via the `libs` argument.
#'
#' All projections computed in this environment rely on D3.js spherical geometry,
#' where the Earth is modeled as a sphere rather than an ellipsoid. This allows
#' fast and consistent computation of map projections and geometric transformations.
#'
#' @param libs Character vector of JavaScript library URLs to load.
#' By default, libraries are loaded from the jsDelivr CDN. Users may replace
#' these with local files, pinned versions, or alternative CDNs.
#'
#' @param verbose Logical. If TRUE, prints loading status for each library.
#'
#' @return
#' A V8 JavaScript context with the D3.js geospatial stack loaded and ready
#' for cartographic computations.
#'
#' @export
#'
#' @examples
#' ct <- planisphere::new_v8_context()
new_v8_context <- function(
  libs = c(
    "https://cdn.jsdelivr.net/npm/d3@7",
    "https://cdn.jsdelivr.net/npm/d3-geo@3",
    "https://cdn.jsdelivr.net/npm/d3-geo-polygon@2",
    "https://cdn.jsdelivr.net/npm/d3-geo-projection@4"
  ),
  verbose = TRUE
) {
  ct <- V8::v8()

  # V8 version (safe parsing)
  v8_version <- sub(
    ".*V8 engine ([0-9.]+)>.*",
    "\\1",
    capture.output(ct)[1]
  )

  if (verbose) {
    message(sprintf(
      "V8 engine %s initialized",
      v8_version
    ))

    # Only show message if libs is not NULL and not empty
    if (!is.null(libs) && length(libs) > 0) {
      message("Loading additional JavaScript libraries")
    }
  }

  # Load libs if provided
  if (!is.null(libs) && length(libs) > 0) {
    for (l in libs) {
      status <- tryCatch(
        {
          suppressWarnings(
            suppressMessages(
              ct$source(l)
            )
          )
          "✔"
        },
        error = function(e) {
          "✖"
        }
      )

      if (verbose) {
        message(sprintf("%s %s", status, l))
      }
    }
  }

  if (verbose) message("Planisphere is ready 🌐")

  ct
}
