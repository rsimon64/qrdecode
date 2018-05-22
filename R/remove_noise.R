remove_noise <- function(anImage) {
  anImage %>%
    grayscale %>%
    blur_anisotropic(amplitude = 1) %>%
    #cannyEdges()
    mclosing_square(size = 30)
}
