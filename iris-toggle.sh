#!/usr/bin/env sh

set -x

IFACE="wg0"

ip link sh "$IFACE" > /dev/null 2>&1
status=$?

set -e
if [ $status -eq 0 ]; then
	sudo wg-quick down "$IFACE-client"
else
	sudo wg-quick up "$IFACE-client"
fi
