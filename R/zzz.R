.planisphere <- new.env(parent = emptyenv())

.onLoad <- function(libname, pkgname) {
  
  js <- system.file("js", package = pkgname)
  
  libs <- list(
    list(name = "d3", version = "7.9.0", file = "d3@7.js"),
    list(name = "d3-geo-polygon", version = "2.0.1", file = "d3-geo-polygon@2.js"),
    list(name = "d3-geo-projection", version = "4.0.0", file = "d3-geo-projection@4.js"),
    list(name = "d3-geo", version = "3.1.1", file = "d3-geo@3.js"),
    list(name = "additional script", version = "spilhaus.js", file = "spilhaus.js")
    )
  

  # Create V8 context
  .planisphere$ct <- V8::v8()
  
  # Retrieve V8 engine version from JS runtime

  packageStartupMessage(sprintf(
    "V8 engine %s initialized",
    sub(".*V8 engine ([0-9.]+)>.*", "\\1", utils::capture.output( .planisphere$ct)[1])
  ))
  
  packageStartupMessage("Loading D3.js geospatial stack")
  
  for (lib in libs) {
    
    path <- file.path(js, lib$file)
    
    tryCatch({
      
      .planisphere$ct$source(path)
      
      packageStartupMessage(sprintf(
        "- %s (%s)",
        lib$name,
        lib$version
      ))
      
    }, error = function(e) {
      
      packageStartupMessage(sprintf(
        "- %s failed to load",
        lib$name
      ))
    })
  }
  
  # + some js helpers
  .planisphere$ct$source(file.path(js, "helpers.js"))
  
  packageStartupMessage("Planisphere is ready")
}