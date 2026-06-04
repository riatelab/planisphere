#' @title Overview of map projections
#'
#' @param projections vector of projection names
#' @param sample nb of maps to display (randomly)
#' @param ncol ncol
#' @return a base R plot.
#'
#' @export
#'
#' @examples
#' projs <- planisphere::registry(type = "core")
#' planisphere::gallery(projs)
gallery <- function(sample = 12, projections = NULL, ncol = 4) {
  
  
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
        additional_layers = TRUE
      ),
      error = function(e) {
        message("Failed: ", proj)
        return(NULL)
      }
    )
    
    if (is.null(p)) next
    
    planisphere::display(p, title = proj)
  }
}