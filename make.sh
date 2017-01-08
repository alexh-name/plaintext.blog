#!/bin/sh

SHELLPATH="/bin"

# ./scripts/gen-layout.sh
SHELL="${SHELLPATH}/ksh" make
./scripts/insert-files.sh
# ./scripts/gen-thispage.sh
./scripts/gen-gitlink.sh
# ./scripts/gen-css.sh
./scripts/tree.sh
