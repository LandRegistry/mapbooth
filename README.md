# Map Booth

Create static maps for the public property page for a Land Registry title using [TileMill](https://www.mapbox.com/tilemill/).

In your Ubuntu server VM:

    $ git clone https://github.com/LandRegistry/mapbooth.git
    $ cd mapbooth
    $ ./install.sh

On your local machine:

    $ ssh -f -N -CA user@hostname -L 20009:localhost:20009 -L 20008:localhost:20008
    $ open http://localhost:20009

## Render a pair of maps for each title
* https://www.mapbox.com/tilemill/docs/manual/exporting/
