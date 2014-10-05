#!/bin/sh

#
# use imposm to load OSM data into postgres
#
# https://www.mapbox.com/tilemill/docs/guides/osm-bright-ubuntu-quickstart/
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

# install OSM Bright map style
[ ! -d osm-bright ] && git clone https://github.com/mapbox/osm-bright.git

# extract downloaded OSM data into cache
imposm -U postgres -d osm -m osm-bright/imposm-mapping.py --read --merge-cache ${PBF}

# write the data stored in the cache to the OSM database
imposm -U npmap -d osm -m osm-bright/imposm-mapping.py --write --optimize --deploy-production-tables
