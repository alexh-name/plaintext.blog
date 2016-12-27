#!/bin/sh

set -eu

if [ ! -f wswsh ]; then
  wget https://github.com/alexh-name/wswsh/raw/master/wswsh
  chmod +x wswsh
else
  echo 'wswsh already there.'
fi

if [ ! -f ahrf.awk ]; then
  wget https://github.com/alexh-name/ahrf/raw/prod_zckr/ahrf.awk
  chmod +x ahrf.awk
else
  echo 'ahrf.awk already there.'
fi
