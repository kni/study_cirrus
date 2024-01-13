#!/bin/sh
set -e
echo OK
pwd
uname -a
freebsd-version
dmesg | head -n 20
ls -l /usr/ports/ | head
