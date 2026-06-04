# Overview of map projections

Overview of map projections

## Usage

``` r
gallery(sample = 12, projections = NULL, ncol = 4)
```

## Arguments

- sample:

  nb of maps to display (randomly)

- projections:

  vector of projection names

- ncol:

  ncol

## Value

a base R plot.

## Examples

``` r
projs <- planisphere::registry(type = "core")
planisphere::gallery(projs)
#> Rendering: Airocean 
#> Failed: Airocean
#> Rendering: Airy 
#> Failed: Airy
#> Rendering: Aitoff 
#> Failed: Aitoff
#> Rendering: Albers 
#> Failed: Albers
#> Rendering: Armadillo 
#> Failed: Armadillo
#> Rendering: August 
#> Failed: August
#> Rendering: AzimuthalEqualArea 
#> Failed: AzimuthalEqualArea
#> Rendering: AzimuthalEquidistant 
#> Failed: AzimuthalEquidistant
#> Rendering: Baker 
#> Failed: Baker
#> Rendering: Berghaus 
#> Failed: Berghaus
#> Rendering: Bertin1953 
#> Failed: Bertin1953
#> Rendering: Boggs 
#> Failed: Boggs
#> Rendering: Bonne 
#> Failed: Bonne
#> Rendering: Bottomley 
#> Failed: Bottomley
#> Rendering: Bromley 
#> Failed: Bromley
#> Rendering: CahillKeyes 
#> Failed: CahillKeyes
#> Rendering: ChamberlinAfrica 
#> Failed: ChamberlinAfrica
#> Rendering: Collignon 
#> Failed: Collignon
#> Rendering: ComplexLog 
#> Failed: ComplexLog
#> Rendering: ConicConformal 
#> Failed: ConicConformal
#> Rendering: ConicEqualArea 
#> Failed: ConicEqualArea
#> Rendering: ConicEquidistant 
#> Failed: ConicEquidistant
#> Rendering: Craig 
#> Failed: Craig
#> Rendering: Craster 
#> Failed: Craster
#> Rendering: Cubic 
#> Failed: Cubic
#> Rendering: CylindricalEqualArea 
#> Failed: CylindricalEqualArea
#> Rendering: CylindricalStereographic 
#> Failed: CylindricalStereographic
#> Rendering: Deltoidal 
#> Failed: Deltoidal
#> Rendering: Dodecahedral 
#> Failed: Dodecahedral
#> Rendering: Eckert1 
#> Failed: Eckert1
#> Rendering: Eckert2 
#> Failed: Eckert2
#> Rendering: Eckert3 
#> Failed: Eckert3
#> Rendering: Eckert4 
#> Failed: Eckert4
#> Rendering: Eckert5 
#> Failed: Eckert5
#> Rendering: Eckert6 
#> Failed: Eckert6
#> Rendering: Eisenlohr 
#> Failed: Eisenlohr
#> Rendering: EqualEarth 
#> Failed: EqualEarth
#> Rendering: Equirectangular 
#> Failed: Equirectangular
#> Rendering: Fahey 
#> Failed: Fahey
#> Rendering: Foucaut 
#> Failed: Foucaut
#> Rendering: FoucautSinusoidal 
#> Failed: FoucautSinusoidal
#> Rendering: Gilbert 
#> Failed: Gilbert
#> Rendering: Gingery 
#> Failed: Gingery
#> Rendering: Ginzburg4 
#> Failed: Ginzburg4
#> Rendering: Ginzburg5 
#> Failed: Ginzburg5
#> Rendering: Ginzburg6 
#> Failed: Ginzburg6
#> Rendering: Ginzburg8 
#> Failed: Ginzburg8
#> Rendering: Ginzburg9 
#> Failed: Ginzburg9
#> Rendering: Gnomonic 
#> Failed: Gnomonic
#> Rendering: Gringorten 
#> Failed: Gringorten
#> Rendering: GringortenQuincuncial 
#> Failed: GringortenQuincuncial
#> Rendering: Guyou 
#> Failed: Guyou
#> Rendering: Hammer 
#> Failed: Hammer
#> Rendering: Healpix 
#> Failed: Healpix
#> Rendering: Hill 
#> Failed: Hill
#> Rendering: Homolosine 
#> Failed: Homolosine
#> Rendering: Hufnagel 
#> Failed: Hufnagel
#> Rendering: Hyperelliptical 
#> Failed: Hyperelliptical
#> Rendering: Icosahedral 
#> Failed: Icosahedral
#> Rendering: Imago 
#> Failed: Imago
#> Rendering: InterruptedBoggs 
#> Failed: InterruptedBoggs
#> Rendering: InterruptedHomolosine 
#> Failed: InterruptedHomolosine
#> Rendering: InterruptedMollweide 
#> Failed: InterruptedMollweide
#> Rendering: InterruptedMollweideHemispheres 
#> Failed: InterruptedMollweideHemispheres
#> Rendering: InterruptedQuarticAuthalic 
#> Failed: InterruptedQuarticAuthalic
#> Rendering: InterruptedSinuMollweide 
#> Failed: InterruptedSinuMollweide
#> Rendering: InterruptedSinusoidal 
#> Failed: InterruptedSinusoidal
#> Rendering: Kavrayskiy7 
#> Failed: Kavrayskiy7
#> Rendering: Larrivee 
#> Failed: Larrivee
#> Rendering: Laskowski 
#> Failed: Laskowski
#> Rendering: Loximuthal 
#> Failed: Loximuthal
#> Rendering: Mercator 
#> Failed: Mercator
#> Rendering: Miller 
#> Failed: Miller
#> Rendering: ModifiedStereographicAlaska 
#> Failed: ModifiedStereographicAlaska
#> Rendering: ModifiedStereographicGs48 
#> Failed: ModifiedStereographicGs48
#> Rendering: ModifiedStereographicGs50 
#> Failed: ModifiedStereographicGs50
#> Rendering: ModifiedStereographicLee 
#> Failed: ModifiedStereographicLee
#> Rendering: ModifiedStereographicMiller 
#> Failed: ModifiedStereographicMiller
#> Rendering: Mollweide 
#> Failed: Mollweide
#> Rendering: MtFlatPolarParabolic 
#> Failed: MtFlatPolarParabolic
#> Rendering: MtFlatPolarQuartic 
#> Failed: MtFlatPolarQuartic
#> Rendering: MtFlatPolarSinusoidal 
#> Failed: MtFlatPolarSinusoidal
#> Rendering: NaturalEarth1 
#> Failed: NaturalEarth1
#> Rendering: NaturalEarth2 
#> Failed: NaturalEarth2
#> Rendering: NellHammer 
#> Failed: NellHammer
#> Rendering: Nicolosi 
#> Failed: Nicolosi
#> Rendering: Orthographic 
#> Failed: Orthographic
#> Rendering: Patterson 
#> Failed: Patterson
#> Rendering: PeirceQuincuncial 
#> Failed: PeirceQuincuncial
#> Rendering: Polyconic 
#> Failed: Polyconic
#> Rendering: PolyhedralButterfly 
#> Failed: PolyhedralButterfly
#> Rendering: PolyhedralCollignon 
#> Failed: PolyhedralCollignon
#> Rendering: PolyhedralVoronoi 
#> Failed: PolyhedralVoronoi
#> Rendering: PolyhedralWaterman 
#> Failed: PolyhedralWaterman
#> Rendering: RectangularPolyconic 
#> Failed: RectangularPolyconic
#> Rendering: Rhombic 
#> Failed: Rhombic
#> Rendering: Robinson 
#> Failed: Robinson
#> Rendering: Satellite 
#> Failed: Satellite
#> Rendering: SinuMollweide 
#> Failed: SinuMollweide
#> Rendering: Sinusoidal 
#> Failed: Sinusoidal
#> Rendering: Spilhaus 
#> Failed: Spilhaus
#> Rendering: Stereographic 
#> Failed: Stereographic
#> Rendering: TetrahedralLee 
#> Failed: TetrahedralLee
#> Rendering: Times 
#> Failed: Times
#> Rendering: TransverseMercator 
#> Failed: TransverseMercator
#> Rendering: TwoPointAzimuthalUsa 
#> Failed: TwoPointAzimuthalUsa
#> Rendering: TwoPointEquidistantUsa 
#> Failed: TwoPointEquidistantUsa
#> Rendering: VanDerGrinten 
#> Failed: VanDerGrinten
#> Rendering: VanDerGrinten2 
#> Failed: VanDerGrinten2
#> Rendering: VanDerGrinten3 
#> Failed: VanDerGrinten3
#> Rendering: VanDerGrinten4 
#> Failed: VanDerGrinten4
#> Rendering: Wagner 
#> Failed: Wagner
#> Rendering: Wagner4 
#> Failed: Wagner4
#> Rendering: Wagner6 
#> Failed: Wagner6
#> Rendering: Wagner7 
#> Failed: Wagner7
#> Rendering: Wiechel 
#> Failed: Wiechel
#> Rendering: Winkel3 
#> Failed: Winkel3
```
