# Project geographic data using a D3.js projection

Projects spatial data using D3.js geographic projections executed in a
V8 JavaScript context. The projection is performed in spherical
coordinates, following D3.js design principles, where the Earth is
modeled as a sphere rather than an ellipsoid.

## Usage

``` r
project(
  x,
  proj = "geoAzimuthalEqualArea",
  rotate = NULL,
  reflectX = NULL,
  reflectY = NULL,
  scale = 500,
  center = NULL,
  parallel = NULL,
  parallels = NULL,
  clipExtent = NULL,
  clip = TRUE,
  graticule = c(10, 10),
  additional_layers = FALSE,
  verbose = FALSE,
  ct = .planisphere$ct,
  ...
)
```

## Arguments

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

- parallel:

  Optional standard parallel of the projection

- parallels:

  Optional standard parallels of the projection

- clip:

  If TRUE, clips the projected geometries to the projected sphere.

- graticule:

  Numeric vector of longitude/latitude step size for graticule
  generation.

- ct:

  A custom V8 JavaScript context if needed. See
  [`new_v8_context()`](https://rneocarto.github.io/planisphere/reference/new_v8_context.md).

- ...:

  Additional parameters passed to the projection builder.

- additional_ayers:

  Logical. If TRUE, adds graticule and sphere layers. In this case, the
  function returns a list. If FALSE (default), it returns a spatial data
  frame.

## Value

If `additionalLayers = FALSE`, a single `sf` object corresponding to the
projected basemap.

If `additionalLayers = TRUE`, a list of `sf` objects:

- `basemap`: projected input geometries

- `sphere`: outline of the projected globe

- `graticule`: projected graticule lines

## Details

D3 geographic projections are based on spherical geometry. All
transformations assume a perfect sphere, which differs from traditional
GIS pipelines that often rely on ellipsoidal datums (e.g., WGS84). As a
result, this function is primarily intended for visualization and
cartographic rendering rather than high-precision geodetic computation.

## Examples

``` r
library(sf)
world <- st_read(
  system.file("gpkg/land.gpkg", package = "planisphere"),
  quiet = TRUE
)

result <- planisphere::project(x = world, proj = "InterruptedBoggs")
```
