# Display a projected planisphere

Render a complete planisphere from a projected object created with
[`project()`](https://rneocarto.github.io/planisphere/reference/project.md).
The display includes the projected sphere outline, graticule, and
geographic features.

## Usage

``` r
display(x, title = NULL)
```

## Arguments

- x:

  A list returned by
  [`project()`](https://rneocarto.github.io/planisphere/reference/project.md),
  containing three `sf` objects:

  - `basemap`: projected geographic features

  - `sphere`: outline of the projected globe

  - `graticule`: projected latitude/longitude grid

- title:

  Character string. Optional title to add to the plot. Default is NULL.

## Value

a base R plot.

## Details

The visualization follows the D3.js spherical projection model used in
the package. The rendering order is: 1. Sphere background 2. Graticule
3. Projected landmass (basemap) 4. Sphere outline

All geometries are expected to be already projected in spherical
coordinates. This function is intended for fast visualization and
exploration of D3-based projections.

## See also

[`project`](https://rneocarto.github.io/planisphere/reference/project.md),
`init`

## Examples

``` r
library(sf)
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE
world <- st_read(
  system.file("gpkg/land.gpkg", package = "planisphere"),
  quiet = TRUE
)

result <- planisphere::project(x = world, proj = "geoInterruptedBoggs")
#> Error in clean(x): object 'world' not found
planisphere::display(result)
#> Error: object 'result' not found
```
