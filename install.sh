#!/bin/sh

# setup mapbooth on a Linux server
# idempotent shell script, but should really be Puppet/Ansible configuration

./install/tilemill.sh
./install/postgres.sh
./install/osm-bright.sh
