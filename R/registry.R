#' @title List available map projections
#'
#' @description
#' Returns the list of available map projections registered in
#' \pkg{planisphere}. Projections are organized into thematic families
#' to facilitate exploration and selection.
#'
#' By default, all projections are returned as a single sorted character vector.
#' Alternatively, a specific family of projections can be requested.
#'
#' @param type Character. Optional projection family. Must be one of:
#'   "cylindrical", "conic", "azimuthal", "perspective",
#'   "pseudocylindrical", "interrupted", "polyhedral",
#'   "quincuncial", "regional", "pseudoazimuthal", "miscellaneous".
#'
#' @return
#' A sorted unique character vector of projection names.
#' If `type` is provided, only projections belonging to the selected family
#' are returned.
#'
#' @export
#'
#' @examples
#' # List all available projections
#'
#' # List cylindrical projections
#' registry(type = "cylindrical")
#'
#' # Explore regional projections
#' registry("regional")
#'
#' # Visualize polyhedral projections
#' gallery(projections = registry("polyhedral"), verbose = FALSE)
registry <- function(type = NULL) {
  
  registry <- d3_geo_projections
  
  if (is.null(type)) {
    projections <- unlist(registry, use.names = FALSE)
  } else {
    type <- match.arg(type, names(registry))
    projections <- registry[[type]]
  }
  
  projections <- unique(sort(projections))
  
    return(projections)
}

d3_geo_projections <- list(
  
  cylindrical = c(
    "Equirectangular","Mercator","TransverseMercator",
    "Miller","CylindricalEqualArea","CylindricalStereographic"
  ),
  
  conic = c(
    "ConicConformal","ConicEqualArea","ConicEquidistant",
    "Albers","Bonne","Polyconic","RectangularPolyconic"
  ),
  
  azimuthal = c(
    "AzimuthalEqualArea","AzimuthalEquidistant",
    "Gnomonic","Stereographic"
  ),
  
  perspective = c(
    "Orthographic","Satellite","Armadillo"
  ),
  
  pseudocylindrical = c(
    "Sinusoidal","Mollweide","Homolosine","SinuMollweide",
    "Eckert1","Eckert2","Eckert3","Eckert4","Eckert5","Eckert6",
    "Craster","Fahey","Kavrayskiy7",
    "Wagner","Wagner4","Wagner6","Wagner7",
    "NaturalEarth1","NaturalEarth2","EqualEarth"
  ),
  
  interrupted = c(
    "InterruptedHomolosine",
    "InterruptedSinusoidal",
    "InterruptedBoggs",
    "InterruptedSinuMollweide",
    "InterruptedMollweide",
    "InterruptedMollweideHemispheres",
    "InterruptedQuarticAuthalic"
  ),
  
  polyhedral = c(
    "CahillKeyes","Airocean","Cubic","Dodecahedral",
    "Icosahedral","PolyhedralButterfly","PolyhedralCollignon",
    "PolyhedralWaterman","PolyhedralVoronoi",
    "Rhombic","Deltoidal","TetrahedralLee"
  ),
  
  quincuncial = c(
    "PeirceQuincuncial",
    "GringortenQuincuncial",
    "Guyou",
    "Spilhaus"
  ),
  
  regional = c(
    "ChamberlinAfrica",
    "TwoPointAzimuthalUsa",
    "TwoPointEquidistantUsa",
    "ModifiedStereographicAlaska",
    "ModifiedStereographicGs48",
    "ModifiedStereographicGs50",
    "ModifiedStereographicLee",
    "ModifiedStereographicMiller",
    "Robinson",
    "Winkel3",
    "Patterson"
  ),
  
  pseudoazimuthal = c(
    "Aitoff",
    "August",
    "Hammer",
    "NellHammer",
    "Wiechel"
  ),
  
  miscellaneous = c(
    "Airy","Baker","Berghaus","Bertin1953","Boggs","Bottomley","Bromley",
    "Collignon","Craig",
    "Eisenlohr","Foucaut","FoucautSinusoidal",
    "Gilbert","Gingery",
    "Ginzburg4","Ginzburg5","Ginzburg6","Ginzburg8","Ginzburg9",
    "Gringorten","Healpix","Hill","Hufnagel","Hyperelliptical",
    "Larrivee","Laskowski","Loximuthal",
    "MtFlatPolarParabolic","MtFlatPolarQuartic","MtFlatPolarSinusoidal",
    "Nicolosi","Times",
    "VanDerGrinten","VanDerGrinten2","VanDerGrinten3","VanDerGrinten4",
    "Imago","ComplexLog"
  )
)