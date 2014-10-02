#!/bin/sh

# setup mapbooth on a Linux server
# TBD: turn this script into Puppet/Ansible configuration

sudo add-apt-repository -y ppa:developmentseed/mapbox
sudo apt-get update
sudo apt-get install tilemill libmapnik nodejs

# files: /usr/share/tilemill
# config: /etc/tilemill/tilemill.config
# logs: /var/log/tilemill
# run as tilemill user using upstart:
sudo start tilemill

# you can tunnel the TileMill app to your machine with
# ssh -CA USER@HOSTNAME-L 20009:localhost:20009 -L 20008:localhost:20008
# and visit http://localhost:20009 in your browser

#
# following notes from:
# https://www.mapbox.com/tilemill/docs/guides/osm-bright-ubuntu-quickstart/
#
# postgis version depends upon Ubuntu version, this for 14.04 LTS (Trusty Tahr)
sudo apt-get install -y postgresql postgis postgresql-9.3-postgis-2.1
sudo -U postgres createuser gisuser
sudo -U postgres createdb --encoding=UTF8 --owner=gisuser gis
sudo -U postgres createlang plpgsql gis

sudo aptitude install -y build-essential python-dev protobuf-compiler \
    libprotobuf-dev libtokyocabinet-dev python-psycopg2 libgeos-c1

sudo apt-get install -y python-pip
sudo pip install imposm

# trust local postgres connections
sudo cp pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
sudo /etc/init.d/postgresql restart

psql -U postgres -c "create database osm;"
psql -U postgres -d osm -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
psql -U postgres -d osm -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql

curl http://download.geofabrik.de/europe/british-isles-latest.osm.pbf > map.osm.pbf

sudo apt-get install -y git
git clone https://github.com/mapbox/osm-bright.git

imposm -U postgres -d osm -m osm-bright/imposm-mapping.py \
    --read --write --optimize --deploy-production-tables map.osm.pbf
