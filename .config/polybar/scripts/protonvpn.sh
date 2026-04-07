#!/usr/bin/env bash
# set -euo pipefail
#set -ex

# protonvpn status --simple | grep -v "Server list"
pstatus=$(protonvpn status)
server=$(echo "$pstatus" | grep 'Server: ' | cut -d' ' -f2)

# If no server (i.e., disconnected or something)
if [ -z "$server" ]; then
	# Print everything after "Status: "
	to_print=$(echo "$pstatus" | cut -d' ' -f2-)
else
	to_print=$server
fi

echo -n "ProtonVPN: $to_print"
