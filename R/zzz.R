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

  for (lib in libs) {
    
    path <- file.path(js, lib$file)
    
    tryCatch({
      .planisphere$ct$source(path)
    }, error = function(e) {
      
    })
  }
  
  # + some js helpers
  .planisphere$ct$source(file.path(js, "helpers.js"))
}