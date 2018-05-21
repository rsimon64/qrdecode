# https://github.com/IdreesInc/QR-Code-Extractor

# Step One: Remove noise from sample image
Convert original image to greyscale  imager::grayscale         
Apply Gaussian blur to reduce noise imager::blur_anisotropic
Apply Canny edge filter to eliminate distractions  imager::cannyEdges

# Step Two: Narrow down search to only QR code locators
Find all remaining contours  imager::contour
Filter all contours with approximate vertex count of four -> inspect list result from contour
Filter all quadrilaterals that are approximately squares and have a certain number of children

# Step Three: Locate the locators
Loop through all squares
Find all squares that are similar in size to the current square
If the closest two squares to the current square are similar distances away, estimate that this square is the upper-left locator
With the other squares, find the angle from the upper-left vertex to determine the orientation of the QR code

# Step Four: Find the alignment pattern square (colloquially called "tiny square" in my code)
While searching through squares in previous step, store any squares that are less than half the size of the locator squares
After determining locator orientations, calculate the midpoint of the QR code
Select from the possible alignment pattern squares the one closest to the midpoint that is also within the bounds of the code itself
If alignment pattern is found:
Determine fourth corner of the QR code to be a rational distance from the alignment pattern (in a direction opposite of the midpoint)
If no alignment pattern is found (smaller QR codes lack this, or the camera may not detect it):
Determine edges of the locators that are along the edges of the entire QR code that would intersect to form the fourth corner
Find line intersection and determine that point to be the fourth corner

# Step Five: Compensate for perspective warping and extract the code
For each code, warp the vertices into a square to fix alignment
Scale down with cubic interpolation into 29x29 pixel square (change dimensions for different types of codes)
Convert to one bit black and white by thresholding the image
Return formatted codes in list
