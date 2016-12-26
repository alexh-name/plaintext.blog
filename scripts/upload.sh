#!/bin/sh

. ./wswsh.conf

rsync -qaPh --del dest/ /var/www/virtual/$VUSER/$WURL/
