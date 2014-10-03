#!/bin/sh

#
# install postgres for holding OSM maps rendered by TileMill
#
set -e -x

# postgis version depends upon Ubuntu version, these for 14.04 LTS (Trusty Tahr)
POSTGRES_VERSION=9.3
POSTGIS_VERSION=2.1

# install packages
sudo apt-get install -y postgresql postgis
sudo apt-get install -y postgresql-${POSTGRES_VERSION}-postgis-${POSTGIS_VERSION}

# move database to /mnt
if [ ! -d /mnt/postgresql ] ; then
    sudo mv /var/lib/postgresql/${POSTGRES_VERSION} /mnt/postgresql
    sudo ln -s /mnt/postgresql /var/lib/postgresql/${POSTGRES_VERSION}
fi

# trust local postgres connections
sudo cp etc/pg_hba.conf /etc/postgresql/${POSTGRES_VERSION}/main/pg_hba.conf

# restart postgres
sudo /etc/init.d/postgresql restart

# add gis users
(
    set +e
    sudo -u postgres createuser gisuser
    sudo -u postgres createdb --encoding=UTF8 --owner=gisuser gis
    sudo -u postgres createlang plpgsql gis
)

# create database
psql -U postgres -c "create database osm;"
psql -U postgres -d osm -c "ALTER USER osm WITH PASSWORD 'osm';"
psql -U postgres -d osm -f /usr/share/postgresql/${POSTGRES_VERSION}/contrib/postgis-${POSTGIS_VERSION}/postgis.sql
psql -U postgres -d osm -f /usr/share/postgresql/${POSTGRES_VERSION}/contrib/postgis-${POSTGIS_VERSION}/spatial_ref_sys.sql
