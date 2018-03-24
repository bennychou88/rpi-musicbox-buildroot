#!/bin/bash

target="$(dirname $0)/buildroot/output/target"

DIRECTORIES="
home/mpd
home/persistent/ro
home/persistent/rw
"

$(cd $target && mkdir -p $DIRECTORIES)

test -f $target/etc/ssh/ssh_host_key      || ssh-keygen -q -f $target/etc/ssh/ssh_host_key -N '' -t rsa1
test -f $target/etc/ssh/ssh_host_rsa_key  || ssh-keygen -f $target/etc/ssh/ssh_host_rsa_key -N '' -t rsa
test -f $target/etc/ssh/ssh_host_dsa_key  || ssh-keygen -f $target/etc/ssh/ssh_host_dsa_key -N '' -t dsa
test -f $target/etc/ssh/ssh_host_ecdsa_key|| ssh-keygen -f $target/etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521

mkdir -p $target/root/.ssh
test -f ~/.ssh/id_rsa.pub && cat ~/.ssh/id_rsa.pub > $target/root/.ssh/authorized_keys
chmod 700 $target/root/.ssh
chmod 600 $target/root/.ssh/authorized_keys
