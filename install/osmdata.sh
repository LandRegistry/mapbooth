#!/bin/sh

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
sudo pip install imposm

# download OSM data
PBF=british-isles-latest.osm.pbf
wget -N http://download.geofabrik.de/europe/$PBF

wget -N http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip
unzip simplified-land-polygons-complete-3857.zip

wget -N http://data.openstreetmapdata.com/land-polygons-split-3857.zip
unzip land-polygons-split-3857.zip

# install OSM Bright map style
git clone https://github.com/mapbox/osm-bright.git

# import data into postgres
imposm -U postgres -d osm -m osm-bright/imposm-mapping.py \
    --read --write --optimize --deploy-production-tables ${PBF}
