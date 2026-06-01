# Project geographic data using a D3.js projection

Projects spatial data using D3.js geographic projections executed in a
V8 JavaScript context. The projection is performed in spherical
coordinates, following D3.js design principles, where the Earth is
modeled as a sphere rather than an ellipsoid.

## Usage

``` r
project(
  ct,
  x,
  proj = "geoInterruptedHomolosine",
  rotate = NULL,
  reflectX = NULL,
  reflectY = NULL,
  scale = 6378137,
  center = NULL,
  reverse = TRUE,
  clipOutline = TRUE,
  graticule = c(10, 10),
  ...
)
```

## Arguments

- ct:

  A V8 JavaScript context created with
  [`init()`](https://rneocarto.github.io/planisphere/reference/init.md).

- x:

  An `sf` spatial dataframe to project.

- proj:

  A D3 projection name or constructor (e.g. "geoInterruptedHomolosine").

- rotate:

  Rotation parameters passed to the projection.

- reflectX:

  Logical; whether to reflect the projection on the X axis.

- reflectY:

  Logical; whether to reflect the projection on the Y axis.

- scale:

  Projection scale factor (D3 spherical scale, not planar CRS units).

- center:

  Optional projection center.

- reverse:

  If TRUE, flips the Y axis for display consistency in R plots.

- clipOutline:

  If TRUE, clips the projected geometries to the projected sphere.

- graticule:

  Numeric vector of longitude/latitude step size for graticule
  generation.

- ...:

  Additional parameters passed to the projection builder.

## Value

A list of three `sf` objects:

- `basemap`: projected input geometries

- `sphere`: outline of the projected globe

- `graticule`: projected graticule lines

## Details

D3 geographic projections are based on spherical geometry. All
transformations assume a perfect sphere, which differs from traditional
GIS pipelines that often rely on ellipsoidal datums (e.g., WGS84). As a
result, this function is primarily intended for visualization and
cartographic rendering rather than high-precision geodetic computation.

## See also

[`init`](https://rneocarto.github.io/planisphere/reference/init.md)

## Examples

``` r
library(sf)
world <- st_read(
  system.file("gpkg/land.gpkg", package = "planisphere"),
  quiet = TRUE
)

ct <- planisphere::init()
#> Loading JavaScript libraries
#> ✔ https://cdn.jsdelivr.net/npm/d3@7
#> ✔ https://cdn.jsdelivr.net/npm/d3-geo@3
#> ✔ https://cdn.jsdelivr.net/npm/d3-geo-projection@4
#> ✔ https://cdn.jsdelivr.net/npm/d3-geo-polygon@1
result <- planisphere::project(ct, x = world, proj = "geoInterruptedBoggs")
#> D3.js projection used: d3.geoInterruptedBoggs().scale(6378137)
```
