#!/bin/bash

target="$(dirname $0)/buildroot/output/target"

mkdir -p $target/home/mpd

test -f $target/etc/ssh/ssh_host_key      || ssh-keygen -q -f $target/etc/ssh/ssh_host_key -N '' -t rsa1
test -f $target/etc/ssh/ssh_host_rsa_key  || ssh-keygen -f $target/etc/ssh/ssh_host_rsa_key -N '' -t rsa
test -f $target/etc/ssh/ssh_host_dsa_key  || ssh-keygen -f $target/etc/ssh/ssh_host_dsa_key -N '' -t dsa
test -f $target/etc/ssh/ssh_host_ecdsa_key|| ssh-keygen -f $target/etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521
