#!/bin/sh

SRCDIR='src'

first_lvl_dirs="$(
  find "${SRCDIR}" -maxdepth 1 -type d \
  | tail -n +2 | sed -e "s/^"${SRCDIR}"//g" -e 's/$/\//g' \
  | sort
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
    printf "%s" "${dir}"
    print "%s" "${file}" | sed 's/\.txt$/.html/g'
    printf "%s" '">'
    printf "%s" "${file}"
    printf "%s\n" '</a></li>'
  done <<<"${FILES}"
}

TREE=$(
  while read dir; do
    descent "${dir}"
    if [ -z "${FILES}" ]; then
      printf "%s" '<a href="'
      printf "%s" "${dir}"
      printf "%s" '">'
      printf "%s" "${dir}"
      printf "%s\n" '</a>'
    else
      printf "%s\n" '<details>'
      printf "%s" '<summary>'
      printf "%s" "${dir}"
      printf "%s\n" '</summary>'
      pages="$( make_links "${dir}" )"
      printf "%s\n" '<ul>'
      printf "%s\n" "${pages}" | sort
      printf "%s\n" '</ul>'
      printf "%s\n" '</details>'
    fi
  done <<< "${first_lvl_dirs}"
)

awk -v tree="${TREE}" '/<!--TREE-->/{sub(/<!--TREE-->/,tree)};{print}' \
  dest/index.html > dest/index.html.tmp
mv dest/index.html.tmp dest/index.html
