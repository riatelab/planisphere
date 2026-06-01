# Flip geometry along Y axis

Internal helper that vertically flips geometries by multiplying Y
coordinates by -1.

## Usage

``` r
flipY(x)
```

## Arguments

- x:

  An `sf` object.

## Value

An `sf` object with flipped Y coordinates.

## Details

This function is used for display normalization in D3-based spherical
projections, where coordinate systems may require inversion of the Y
axis for correct rendering in base R plotting.

It operates directly on the geometry slot of an `sf` object.
