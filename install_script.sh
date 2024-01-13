#!/bin/sh
set -e

echo OK

echo -n 'pwd: ' && pwd
echo -n '$HOME: ' && echo $HOME
echo -n 'uname: ' && uname -a
echo -n 'freebsd-version: ' && freebsd-version

echo
echo dmesg
dmesg | head -n 120

echo
top -b

echo
echo pdf.conf
ls -l /etc/pkg/*
cat /etc/pkg/*

echo
echo ls
ls
