#!/bin/bash

target="$(basedir $0)/buildroot/output/target"

mkdir -p $target/home/mpd

ssh-keygen -q -f $target/etc/ssh/ssh_host_key -N '' -t rsa1
ssh-keygen -f $target/etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -f $target/etc/ssh/ssh_host_dsa_key -N '' -t dsa
ssh-keygen -f $target/etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521
