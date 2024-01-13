#!/bin/sh
set -e
echo OK

echo -n 'pwd: ' && pwd
echo -n 'uname: ' && uname -a
echo -n 'freebsd-version: ' && freebsd-version

echo
echo dmesg
dmesg | head -n 120

echo
top -b


echo
ls -l /usr/ports/README
