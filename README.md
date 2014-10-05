# Map Booth

Create static maps for the public property page for a Land Registry title using [TileMill](https://www.mapbox.com/tilemill/).

$ ./install.sh

On your local machine:
$ ssh -f -N -CA ubuntu@hostname -L 20009:localhost:20009 -L 20008:localhost:20008
$ open http://localhost:20009

## Tile Mill as a server
* https://www.mapbox.com/tilemill/docs/linux-install/
* https://www.mapbox.com/tilemill/docs/guides/ubuntu-service/

## Styling
* https://www.mapbox.com/tilemill/docs/guides/osm-bright-ubuntu-quickstart/
* https://github.com/mapbox/osm-bright

## Inspire polygons for titles

## Render a pair of maps for each title
* https://www.mapbox.com/tilemill/docs/manual/exporting/
