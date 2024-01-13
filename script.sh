#!/bin/sh
set -e
ln -s $HOME/seamonkey-2.53.13 /usr/ports/www/seamonkey
cd /usr/ports/www/seamonkey
make build-depends-list run-depends-list | cut -c 12- | xargs pkg install -A -y
make package

mkdir -p $HOME/pkg
mv work/pkg/* $HOME/pkg
