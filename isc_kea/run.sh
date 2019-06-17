#!/bin/ash

if [ -e /usr/var/kea/kea-dhcp4.kea-dhcp4.pid ]; then
    rm -f /usr/var/kea/kea-dhcp4.kea-dhcp4.pid
fi
if [ -e /usr/var/kea/kea-dhcp6.kea-dhcp6.pid ]; then
    rm -f /usr/var/kea/kea-dhcp6.kea-dhcp6.pid
fi

DEBUG=""

while getopts "4:6:d" opts
do
    case $opts in
        4)
            if [ ! -f $OPTARG ]; then
                exit 1
            else
                nohup sh -c "kea-dhcp4 -c $OPTARG $DEBUG" &
            fi
            ;;
        6)
            if [ ! -f $OPTARG ]; then
                exit 1
            else
                nohup sh -c "kea-dhcp6 -c $OPTARG $DEBUG" &
            fi
            ;;
        d)
            DEBUG="-d"
            ;;
        *)
            exit 1
            ;;
    esac
done
wait