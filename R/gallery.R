#' @title Display a gallery of map projections
#'
#' @description
#' Creates a gallery of projected world maps using the projections
#' available in \pkg{planisphere}. By default, a random sample of
#' projections is selected from the projection registry and displayed
#' in a multi-panel layout.
#'
#' @param sample Integer. Number of projections to display when
#'   `projections = NULL`. Ignored if `projections` is provided.
#'   Set to `NULL` to display all available projections.
#' @param projections Character vector of projection names. If `NULL`,
#'   projections are selected from `registry()`.
#' @param ncol Integer. Number of columns in the gallery layout.
#' @param title Logical. Should projection names be displayed as titles?
#' @param verbose Logical. Display progress messages while rendering
#'   projections.
#'
#' @return
#' Draws a gallery of projected maps in the current graphics device and
#' returns `NULL` invisibly.
#'
#' @details
#' The function uses the bundled world land dataset and applies each
#' selected projection through [project()]. Maps are displayed using
#' [display()] in a base R graphics layout.
#'
#' @export
#'
#' @examples
#' # Display a random sample of 12 projections
#' gallery(verbose = FALSE)
#'
#' # Display selected projections
#' gallery(
#'   projections = c(
#'     "Mercator",
#'     "Robinson",
#'     "Orthographic",
#'     "EqualEarth"
#'   ),
#'   ncol = 2,
#'   verbose = FALSE
#' )
#'

gallery <- function(projections = NULL, sample = 12, ncol = 4, title = TRUE, verbose = TRUE) {
  if (is.null(projections)) {
    projections <- registry()

    if (!is.null(sample)) {
      sample <- min(sample, length(projections))
      projections <- base::sample(projections, sample)
    }

    projections <- sort(projections)
  }

  world <- sf::st_read(
    system.file("gpkg/land.gpkg", package = "planisphere"),
    quiet = TRUE
  )


  n <- length(projections)

  op <- par(
    mfrow = c(ceiling(n / ncol), ncol),
    mar = c(1, 1, 2, 1)
  )
  on.exit(par(op), add = TRUE)

  for (i in seq_along(projections)) {
    proj <- projections[i]

    # fix ConicConformal
    if (proj == "ConicConformal") {
      projfix <- "d3.geoConicConformal().clipExtent([[200, 0],[880, 400]])"
    } else {
      projfix <- proj
    }

    if (verbose) message("Rendering: ", proj)

    p <- tryCatch(
      project(
        x = world,
        proj = projfix,
        additional_layers = TRUE
      ),
      error = function(e) {
        if (verbose) message("Failed: ", proj)
        return(NULL)
      }
    )

    if (is.null(p)) next

    display(
      p,
      title = if (isTRUE(title)) proj else NULL
    )
  }
}
