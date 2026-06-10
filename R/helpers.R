#' Build a D3.js projection chain
#'
#' @description
#' Internal helper that constructs a JavaScript D3 projection call as a string.
#'
#' @details
#' This function translates R projection parameters into a valid D3.js projection
#' constructor chain (e.g. \code{d3.geoOrthographic().rotate([...])}).
#'
#' It is used internally by \code{project()} to generate the projection expression
#' evaluated inside the V8 JavaScript context.
#'
#' @param proj Character. Name of the D3 projection (with or without \code{geo} prefix).
#' @param verbose Logical. If TRUE, prints the generated projection chain.
#' @param ... Additional projection parameters passed as method calls
#' (e.g. rotate, center, scale, reflectX).
#' @keywords internal
#' @noRd
#' @return
#' A character string representing a D3.js projection chain.
#'
build_projection_chain <- function(proj = "geoSomething", verbose = FALSE, ...) {
  extra <- list(...)


  if (grepl("spilhaus", proj, ignore.case = TRUE)) {
    out <- "Spilhaus()"
    if (verbose) message("D3.js projection used: ", out)
    return(invisible(out))
  }

  if (grepl("^\\s*d3\\.", proj)) {
    out <- proj
    if (verbose) message("D3.js projection used: ", out)
    return(invisible(out))
  }

  if (!grepl("^geo", proj)) {
    proj <- paste0("geo", proj)
  }

  chain <- paste0("d3.", proj, "()")

  extra <- extra[!names(extra) %in% c("verbose", "clip", "graticule", "additional_layers")]

  for (nm in names(extra)) {
    val <- extra[[nm]]
    if (is.null(val)) next
    js_val <- switch(nm,
      rotate = paste0("[", paste(val, collapse = ","), "]"),
      center = paste0("[", paste(val, collapse = ","), "]"),
      parallels = paste0("[", paste(val, collapse = ","), "]"),
      reflectX = tolower(as.character(val)),
      clipExtent = paste0(
        "[[", paste(val[[1]], collapse = ","), "],[", paste(val[[2]], collapse = ","), "]]"
      ),
      scale = as.character(val),
      if (is.logical(val)) {
        tolower(as.character(val))
      } else if (is.numeric(val)) {
        as.character(val)
      } else {
        paste0('"', val, '"')
      }
    )

    chain <- paste0(chain, ".", nm, "(", js_val, ")")
  }

  if (verbose) {
    message("D3.js projection used: ", chain)
  }

  invisible(chain)
}

#' Flip geometry along Y axis
#'
#' @description
#' Internal helper that vertically flips geometries by multiplying Y coordinates by -1.
#'
#' @details
#' This function is used for display normalization in D3-based spherical projections,
#' where coordinate systems may require inversion of the Y axis for correct rendering
#' in base R plotting.
#'
#' It operates directly on the geometry slot of an \code{sf} object.
#'
#' @param x An \code{sf} object.
#' @keywords internal
#' @noRd
#' @return
#' An \code{sf} object with flipped Y coordinates.
#'
flipY <- function(x) {
  geom <- sf::st_geometry(x)
  geom <- lapply(geom, function(g) {
    g * c(1, -1)
  })
  sf::st_geometry(x) <- sf::st_sfc(geom, crs = sf::st_crs(x))
  x
}


#' Clean and clip geometries for planar processing
#'
#' @description
#' Internal helper that cleans sf geometries, removes invalid or empty features,
#' and clips data to a slightly reduced world extent in a projected planar CRS.
#'
#' @details
#' Input geometries are assumed to be in WGS84 (EPSG:4326). They are temporarily
#' projected to a planar CRS for robust GEOS operations (e.g. intersection),
#' then returned in WGS84.
#'
#' @param x An sf object in WGS84 (EPSG:4326).
#' @param margin Numeric. Margin applied to world bbox (default 0.01).
#' @param work_crs CRS used for planar computation (default 6933).
#' @param verbose Logical. Print progress messages.
#'
#' @keywords internal
#' @noRd
#'
#' @return An sf object cleaned and clipped.
clean <- function(x) {
  margin <- 0.01
  world_bbox <- sf::st_bbox(c(
    xmin = -180 + margin,
    ymin = -90 + margin,
    xmax =  180 - margin,
    ymax =  90 - margin
  ), crs = sf::st_crs(4326))

  world_sf <- sf::st_as_sfc(world_bbox)


  a <- sf::st_transform(x, 3857)
  b <- sf::st_transform(world_sf, 3857)

  result <- suppressWarnings(sf::st_intersection(a, b))
  result <- sf::st_transform(result, 4326)
}

