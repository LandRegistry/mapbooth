#!/bin/sh

sudo add-apt-repository -y ppa:developmentseed/mapbox
sudo apt-get update
sudo apt-get install -y tilemill libmapnik nodejs

# files: /usr/share/tilemill
# config: /etc/tilemill/tilemill.config
# logs: /var/log/tilemill
# run as tilemill user using upstart:
sudo start tilemill

# you can tunnel the TileMill app to your machine with
# ssh -CA USER@HOSTNAME-L 20009:localhost:20009 -L 20008:localhost:20008
# and visit http://localhost:20009 in your browser
