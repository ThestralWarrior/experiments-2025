# NGINX throughput comparison

* `./genimages.sh [1/2/3]` downloads and builds the tested images and takes about 4
   minutes on average;

      * 1 - original experiment using Unikraft 0.5.0 Tethys - using `hlefeuvre/unikraft-eurosys21`
      * 2 - reduced experiment using Unikraft 0.5.0 Tethys - using `unikraft/custom-nginx-builder`
      * 3 - new experiment using Unikraft 0.19.0 Pan
  
 * `./benchmark.sh` runs the experiment; and,
 * `./plot.py` is used to generate the figure.
