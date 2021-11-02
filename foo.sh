#!/usr/bin/env bash

set -e
declare -a rargs
echo OK
pwd
uname -a
freebsd-version
dmesg | head -n 20
ls -l /usr/ports/ | head
