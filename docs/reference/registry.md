# List available projections

Returns projections from the planisphere registry (d3-geo,
d3-geo-projection, d3-geo-polygon).

## Usage

``` r
registry(type = NULL)
```

## Arguments

- type:

  Projection family: "core", "continuous", "discontinuous",
  "quincuncial", "advanced"

## Value

A character vector or data.frame of projection names.

## Examples

``` r
planisphere::registry()
#>   [1] "Airocean"                        "Airy"                           
#>   [3] "Aitoff"                          "Albers"                         
#>   [5] "Armadillo"                       "August"                         
#>   [7] "AzimuthalEqualArea"              "AzimuthalEquidistant"           
#>   [9] "Baker"                           "Berghaus"                       
#>  [11] "Bertin1953"                      "Boggs"                          
#>  [13] "Bonne"                           "Bottomley"                      
#>  [15] "Bromley"                         "CahillKeyes"                    
#>  [17] "ChamberlinAfrica"                "Collignon"                      
#>  [19] "ComplexLog"                      "ConicConformal"                 
#>  [21] "ConicEqualArea"                  "ConicEquidistant"               
#>  [23] "Craig"                           "Craster"                        
#>  [25] "Cubic"                           "CylindricalEqualArea"           
#>  [27] "CylindricalStereographic"        "Deltoidal"                      
#>  [29] "Dodecahedral"                    "Eckert1"                        
#>  [31] "Eckert2"                         "Eckert3"                        
#>  [33] "Eckert4"                         "Eckert5"                        
#>  [35] "Eckert6"                         "Eisenlohr"                      
#>  [37] "EqualEarth"                      "Equirectangular"                
#>  [39] "Fahey"                           "Foucaut"                        
#>  [41] "FoucautSinusoidal"               "Gilbert"                        
#>  [43] "Gingery"                         "Ginzburg4"                      
#>  [45] "Ginzburg5"                       "Ginzburg6"                      
#>  [47] "Ginzburg8"                       "Ginzburg9"                      
#>  [49] "Gnomonic"                        "Gringorten"                     
#>  [51] "GringortenQuincuncial"           "Guyou"                          
#>  [53] "Hammer"                          "Healpix"                        
#>  [55] "Hill"                            "Homolosine"                     
#>  [57] "Hufnagel"                        "Hyperelliptical"                
#>  [59] "Icosahedral"                     "Imago"                          
#>  [61] "InterruptedBoggs"                "InterruptedHomolosine"          
#>  [63] "InterruptedMollweide"            "InterruptedMollweideHemispheres"
#>  [65] "InterruptedQuarticAuthalic"      "InterruptedSinuMollweide"       
#>  [67] "InterruptedSinusoidal"           "Kavrayskiy7"                    
#>  [69] "Larrivee"                        "Laskowski"                      
#>  [71] "Loximuthal"                      "Mercator"                       
#>  [73] "Miller"                          "ModifiedStereographicAlaska"    
#>  [75] "ModifiedStereographicGs48"       "ModifiedStereographicGs50"      
#>  [77] "ModifiedStereographicLee"        "ModifiedStereographicMiller"    
#>  [79] "Mollweide"                       "MtFlatPolarParabolic"           
#>  [81] "MtFlatPolarQuartic"              "MtFlatPolarSinusoidal"          
#>  [83] "NaturalEarth1"                   "NaturalEarth2"                  
#>  [85] "NellHammer"                      "Nicolosi"                       
#>  [87] "Orthographic"                    "Patterson"                      
#>  [89] "PeirceQuincuncial"               "Polyconic"                      
#>  [91] "PolyhedralButterfly"             "PolyhedralCollignon"            
#>  [93] "PolyhedralVoronoi"               "PolyhedralWaterman"             
#>  [95] "RectangularPolyconic"            "Rhombic"                        
#>  [97] "Robinson"                        "Satellite"                      
#>  [99] "SinuMollweide"                   "Sinusoidal"                     
#> [101] "Spilhaus"                        "Stereographic"                  
#> [103] "TetrahedralLee"                  "Times"                          
#> [105] "TransverseMercator"              "TwoPointAzimuthalUsa"           
#> [107] "TwoPointEquidistantUsa"          "VanDerGrinten"                  
#> [109] "VanDerGrinten2"                  "VanDerGrinten3"                 
#> [111] "VanDerGrinten4"                  "Wagner"                         
#> [113] "Wagner4"                         "Wagner6"                        
#> [115] "Wagner7"                         "Wiechel"                        
#> [117] "Winkel3"                        
planisphere::registry(type = "core")
#>  [1] "Albers"               "AzimuthalEqualArea"   "AzimuthalEquidistant"
#>  [4] "ConicConformal"       "ConicEqualArea"       "ConicEquidistant"    
#>  [7] "EqualEarth"           "Equirectangular"      "Gnomonic"            
#> [10] "Mercator"             "NaturalEarth1"        "Orthographic"        
#> [13] "Stereographic"        "TransverseMercator"  
```
