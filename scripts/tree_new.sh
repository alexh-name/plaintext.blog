#!/bin/sh

SRCDIR='src'

first_lvl_dirs="$(
  find "${SRCDIR}" -maxdepth 1 -type d \
  | tail -n +2 | sed -e "s/^"${SRCDIR}"//g" -e 's/$/\//g'
)"

function descent {
  dir="$1"
  FILES="$(
    find "${SRCDIR}"/"${dir}" -type f \
    | cut -d '/' -f 4- | sed -e 's/^\///g' -e 's/index.txt$//g'
  )"
}

function make_links {
  dir="$1"
  while read file; do
    printf "%s" '<li><a href="'
    printf "%s" "${dir}${file}"
    printf "%s" '">'
    printf "%s" "${file}"
    printf "%s\n" '</a></li>'
  done <<<"${FILES}"
}

TREE=$(
  while read dir; do
    printf "%s\n" '<details>'
    printf "%s" '<summary>'
    printf "%s" "${dir}"
    printf "%s\n" '</summary>'
    descent "${dir}"
    pages="$( make_links "${dir}" )"
    printf "%s\n" '<ul>'
    printf "%s\n" "${pages}" | sort
    printf "%s\n" '</ul>'
    printf "%s\n" '</details>'
  done <<< "${first_lvl_dirs}"
)

awk -v tree="${TREE}" '/<!--TREE-->/{sub(/<!--TREE-->/,tree)};{print}' \
  dest/index.html > dest/index.html.tmp
mv dest/index.html.tmp dest/index.html
