#!/bin/sh

TREE="$(
  printf "%s\n" '<p class="tree">'
  /home/zckr/.linuxbrew/bin/tree -I 'google73ff9617eecd7684.html|*.css' -H . dest/ \
  | awk 'f;/<h1>Directory Tree/{f=1};/<br><br>/{exit}' \
  | sed 's/\&/\\\\\&/g'
  printf "%s\n" '</p>'
)"

awk -v tree="${TREE}" '/<p>TREE<\/p>/{sub(/<p>TREE<\/p>/,tree)};{print}' dest/index.html > dest/index.html.tmp
mv dest/index.html.tmp dest/index.html
