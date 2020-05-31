#!/bin/sh

mkdir -p /var/log/upstart

while :; do
    sleep 5
    if [ `cut -d. -f1 /proc/uptime` -lt 300 ]; then
        echo -n "Waiting for 20 sec after boot..."
        sleep 20
        echo " done."
    fi
    if [ -f "/root/bin/busybox" ]; then
        /root/bin/busybox ionice -c3 nice -n 19 /usr/local/bin/librespot --name rockrobo -c /tmp >> /var/log/upstart/librespot.log
    else
        nice -n 19 /usr/local/bin/librespot --name rockrobo --disable-audio-cache >> /var/log/upstart/librespot.log
    fi
done
