#' List available projections
#'
#' Returns projections from the planisphere registry
#' (d3-geo, d3-geo-projection, d3-geo-polygon).
#'
#' @param type Projection family: "core", "continuous",
#' "discontinuous", "quincuncial", "advanced"
#'
#' @return A character vector or data.frame of projection names.
#'
#' @export
#'
#' @examples
#' planisphere_projections()
#' planisphere_projections("core")
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
  
  core = c(
    "AzimuthalEqualArea","AzimuthalEquidistant","Gnomonic","Orthographic","Stereographic",
    "ConicConformal","ConicEqualArea","ConicEquidistant","Albers",
    "Equirectangular","Mercator","TransverseMercator",
    "EqualEarth","NaturalEarth1"
  ),
  
  continuous = c(
    "Airy","Aitoff","Armadillo","August",
    "Baker","Berghaus","Bertin1953","Boggs","Bonne","Bottomley","Bromley",
    "ChamberlinAfrica","Collignon",
    "Craig","Craster",
    "CylindricalEqualArea","CylindricalStereographic",
    "Eckert1","Eckert2","Eckert3","Eckert4","Eckert5","Eckert6",
    "Eisenlohr",
    "Fahey","Foucaut","FoucautSinusoidal",
    "Gilbert","Gingery",
    "Ginzburg4","Ginzburg5","Ginzburg6","Ginzburg8","Ginzburg9",
    "Gringorten","Hammer",
    "Healpix","Hill","Homolosine","Hufnagel","Hyperelliptical",
    "Kavrayskiy7",
    "Larrivee","Laskowski", "Loximuthal",
    "Miller",
    "Mollweide",
    "MtFlatPolarParabolic","MtFlatPolarQuartic","MtFlatPolarSinusoidal",
    "NaturalEarth2",
    "NellHammer","Nicolosi",
    "Patterson","Polyconic","RectangularPolyconic","Robinson",
    "Satellite","Sinusoidal","SinuMollweide",
    "Times",
    "TwoPointAzimuthalUsa","TwoPointEquidistantUsa",
    "VanDerGrinten","VanDerGrinten2","VanDerGrinten3","VanDerGrinten4",
    "Wagner","Wagner4","Wagner6","Wagner7",
    "Wiechel","Winkel3"
  ),
  
  discontinuous = c(
    "InterruptedHomolosine",
    "InterruptedSinusoidal",
    "InterruptedBoggs",
    "InterruptedSinuMollweide",
    "InterruptedMollweide",
    "InterruptedMollweideHemispheres",
    "InterruptedQuarticAuthalic"
  ),
  
  quincuncial = c(
    "PeirceQuincuncial",
    "GringortenQuincuncial",
    "Guyou",
    "Spilhaus"
  ),
  
  advanced = c(
    "Imago",
    "ComplexLog",
    "ModifiedStereographicAlaska",
    "ModifiedStereographicGs48",
    "ModifiedStereographicGs50",
    "ModifiedStereographicMiller",
    "ModifiedStereographicLee",
    "CahillKeyes",
    "Airocean",
    "Cubic",
    "Dodecahedral",
    "Rhombic",
    "Deltoidal",
    "Icosahedral",
    "TetrahedralLee",
    "PolyhedralButterfly",
    "PolyhedralCollignon",
    "PolyhedralWaterman",
    "PolyhedralVoronoi"
  )
)