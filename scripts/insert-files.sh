#!/bin/sh

cp $(find src/ -maxdepth 1 -type f) dest/
cp -r src/files/* dest/files/
cp src/files/icon.png dest/
