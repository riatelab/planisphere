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
    if (verbose) message("xxxD3.js projection used: ", out)
    return(invisible(out))
  }
  
  if (grepl("^\\s*d3\\.", proj)) {
    out <- proj
    if (verbose) message("xxxD3.js projection used: ", out)
    return(invisible(out))
  }
  
  if (!grepl("^geo", proj)) {
    proj <- paste0("geo", proj)
  }
  
  chain <- paste0("d3.", proj, "()")
  
  extra <- extra[!names(extra) %in% c("verbose", "reverse", "clip", "graticule", "additional_layers")]
  
  for (nm in names(extra)) {
    val <- extra[[nm]]
    if (is.null(val)) next
    
    js_val <- switch(
      nm,
      rotate = paste0("[", paste(val, collapse = ","), "]"),
      center = paste0("[", paste(val, collapse = ","), "]"),
      reflectX = tolower(as.character(val)),
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