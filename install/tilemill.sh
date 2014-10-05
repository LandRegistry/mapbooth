#!/bin/sh

## install Tile Mill as a server
# https://www.mapbox.com/tilemill/docs/linux-install/
# https://www.mapbox.com/tilemill/docs/guides/ubuntu-service/

sudo add-apt-repository -y ppa:developmentseed/mapbox
sudo apt-get update
sudo apt-get install -y tilemill libmapnik nodejs

# files: /usr/share/tilemill
# config: /etc/tilemill/tilemill.config
# logs: /var/log/tilemill
# run as tilemill user using upstart:
sudo start tilemill
