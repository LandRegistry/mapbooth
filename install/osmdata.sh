#!/bin/sh

#
# install imposm to load OSM data into postgres
#
set -e -x

# PBF_DIR=/europe
# PBF=british-isles-latest.osm.pbf

PBF_DIR=/europe/great-britain
PBF=england-latest.osm.pbf

sudo aptitude install -y build-essential \
    python-dev \
    protobuf-compiler \
    libprotobuf-dev \
    libtokyocabinet-dev \
    python-psycopg2 \
    libgeos-c1

sudo apt-get install -y unzip
sudo apt-get install -y git
sudo apt-get install -y python-pip
sudo apt-get install -y cython
sudo pip install imposm

# download OSM data
wget -N http://download.geofabrik.de$PBF_DIR/$PBF

wget -N http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip
unzip simplified-land-polygons-complete-3857.zip

wget -N http://data.openstreetmapdata.com/land-polygons-split-3857.zip
unzip land-polygons-split-3857.zip

# install OSM Bright map style
git clone https://github.com/mapbox/osm-bright.git

# import data into postgres
imposm -U postgres -d osm -m osm-bright/imposm-mapping.py \
    --read --write --optimize --deploy-production-tables ${PBF}
