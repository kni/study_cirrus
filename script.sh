#!/bin/sh
set -v
set -e

fetch http://ftp.freebsd.org/pub/FreeBSD/ports/ports/ports.tar.gz
rm -rf /usr/ports/*
tar -xzf ports.tar.gz -C /usr


grep PERL5_DEFAULT /usr/ports/Mk/bsd.default-versions.mk
echo ======
ls -l -d /usr/ports/lang/perl5*
echo ======

ln -s /tmp/cirrus-ci-build/seamonkey-2.53.13 /usr/ports/www/seamonkey
cd /usr/ports/www/seamonkey
make build-depends-list run-depends-list | cut -c 12- | xargs pkg install -A -y
make package

mkdir -p /tmp/cirrus-ci-build/pkg
mv work/pkg/* /tmp/cirrus-ci-build/pkg
