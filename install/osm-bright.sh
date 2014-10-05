#!/bin/sh

#
# setup OSMBright Map Box project
#
set -e -x

# install OSM Bright map style
[ ! -d osm-bright ] && git clone https://github.com/mapbox/osm-bright.git
cd osm-bright

# copy in our configuration tweaks
cp ../etc/configure.py .

# download and extract OSM shapefiles
wget -N http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip
unzip -f -o simplified-land-polygons-complete-3857.zip

wget -N http://data.openstreetmapdata.com/land-polygons-split-3857.zip
unzip -f -o land-polygons-split-3857.zip

# clear (any) existing  mapbox project
sudo rm -rf /usr/share/mapbox/project/OSMBright

# build osm-bright mapbox project
sudo mapbox ./make.py

# fixup ownership
sudo chown -R mapbox:mapbox /usr/share/mapbox/project/OSMBright
