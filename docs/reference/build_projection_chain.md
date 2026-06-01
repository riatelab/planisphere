# Build a D3.js projection chain

Internal helper that constructs a JavaScript D3 projection call as a
string.

## Usage

``` r
build_projection_chain(proj = "geoSomething", verbose = TRUE, ...)
```

## Arguments

- proj:

  Character. Name of the D3 projection (with or without `geo` prefix).

- verbose:

  Logical. If TRUE, prints the generated projection chain.

- ...:

  Additional projection parameters passed as method calls (e.g. rotate,
  center, scale, reflectX).

## Value

A character string representing a D3.js projection chain.

## Details

This function translates R projection parameters into a valid D3.js
projection constructor chain (e.g.
`d3.geoOrthographic().rotate([...])`).

It is used internally by
[`project()`](https://rneocarto.github.io/planisphere/reference/project.md)
to generate the projection expression evaluated inside the V8 JavaScript
context.
