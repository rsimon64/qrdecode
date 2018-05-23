locate_QR <- function(anImage) {
  ct <- contours(anImage)
  #   Find all remaining contours  imager::contour


  #   Filter all contours with approximate vertex count of four -> inspect list result from contour
  plot(anImage)
   ct <- dilate_square(anImage, size = 10) %>% contours()
   n <- length(ct)
  quadrats <- list(NULL)
  k <- 1
  for(i in 1:n) {
    if (max(ct[[i]]$y) < 125) {
      quadrats[[k]] <- ct[[i]]
      k = k + 1
    }
  }
  #purrr::walk(quadrats,function(v) lines(v$x,v$y,col="blue"))
  purrr::walk(ct,function(v) lines(v$x,v$y,col="blue"))

  if( is.null(quadrats[[1]])) return(NULL)

  #   Filter all quadrilaterals that are approximately squares and have a certain number of children

}
