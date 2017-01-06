#!/bin/sh

set -eu

if [ ! -f wswsh ]; then
  wget https://github.com/alexh-name/wswsh/raw/prod_zckr/wswsh
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

if [ ! -f src/css/style.css ]; then
  mkdir -p src/css
  wget -O src/css/style.css https://github.com/alexh-name/css/raw/clouds_topbox/style.css
else
  echo 'style.css already there.'
fi
