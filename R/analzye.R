
library(imager)
library(magrittr)
library(purrr)

im <- load.image("img.bmp")

img <- remove_noise(im)
plot(img)
img.px <- img > .9999
img.bin <- as.cimg(img.px)

plot(im)
highlight(img.bin)
ct <- contour(img.bin)

