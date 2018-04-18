#!/bin/sh

TREE="$(
  cd ./dest/
  ../scripts/tree.py
)"

gawk -v tree="${TREE}" '/<!--TREE-->/{sub(/<!--TREE-->/,tree)};{print}' \
  dest/index.html > dest/index.html.tmp
mv dest/index.html.tmp dest/index.html
