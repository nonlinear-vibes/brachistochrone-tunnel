# Brachistochrone in a Uniform-Density Planet
Terrestrial brachistochrone paths + analytical calculations

Visualizes the brachistochrone tunnel inside a spherical, uniform-density planet by plotting the optimal (minimum-time) hypocycloid paths in a 2D disk. For each endpoint separation 
Δθ, the script draws the two mirrored branches, and annotates the legend with the surface distance and travel time.

Example with Earth parameters and Δθ steps of 30°:

![image](docs/preview.png)

Numerically robust near the surface/turning points (small trimming to avoid singularities).

## Quick Start
```matlab
% Earth-sized disk, arcs every 30 degrees
plotBrachistochroneDisk(6378000, 9.81, pi/6);
```
