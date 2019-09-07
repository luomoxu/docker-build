#!/usr/bin/env sh

mkdir -p /var/run/pdns-recursor/

if [ -f /etc/powerdns/recursor.conf ]; then
    pdns_recursor --daemon=no --write-pid=no --config /etc/powerdns/recursor.conf $@
else
    pdns_recursor --daemon=no --write-pid=no $@
fi
