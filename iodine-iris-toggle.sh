#!/usr/bin/env bash

source ~/.bash_functions
IFACE="dns0"
DNS_HOST="io.masq.cc"
TUN_USER="nobody"
SSH_USER="root"
SSH_HOST="192.168.53.1"
SSH_KEY_PATH=~/Dropbox/Keys/info344a.pem
SSH_CONTROL_PATH_STR="~/.ssh/iodine_ssh_tun_control.sock"
SSH_CONTROL_PATH=~/.ssh/iodine_ssh_tun_control.sock
SSH_CONFIG=~/.ssh/config
SSH_CONFIG_LINE="Host $SSH_HOST\n\tHostName $SSH_HOST\n\tControlPath $SSH_CONTROL_PATH_STR"
SQUID_PORT=3128
SOCKS_PORT=9999

ERROR_SSH_CONFIG_MISSING=1
ERROR_SSH_HOST_MISSING_FROM_CONFIG=2

ip link sh "$IFACE" > /dev/null 2>&1
status=$?

if [ ! $status -eq 0 ]; then
	print_info "Iodine tunnel not detected. Creating an Iodine tunnel"
	print_info "Checking for valid SSH config"
	if [ -f "$SSH_CONFIG" -a -r "$SSH_CONFIG" ]; then
		grep -Pz "$SSH_CONFIG_LINE" "$SSH_CONFIG" > /dev/null 2>&1
		status=$?
		if [ ! $status -eq 0 ]; then
			print_error "$SSH_CONFIG exists, but is not configured for $SSH_HOST with the ControlPath directive specifically."
			exit $ERROR_SSH_HOST_MISSING_FROM_CONFIG;
		else
			print_success "SSH config found and acceptable"
		fi
	else
		print_error "$SSH_CONFIG does not exist. A config must be set and configured for $SSH_HOST with the ControlPath directive specifically."
		exit $ERROR_SSH_CONFIG_MISSING;
	fi
	print_info "Prompting for sudo password and Iodine server password"
	# Create Iodine tunnel to the tunnel host and drop privs (from root) after.
	sudo iodine "$DNS_HOST" -u "$TUN_USER"

	print_success "Iodine DNS tunnel configured"
	print_info "Setting up SSH tunnel over Iodine DNS interface"

	# -f means run in the background before command execution
	# -N means don't execute any commands
	# -T means don't allocate a ptty
	# -M means put the control socket in master mode
	# NOTE: ctrl socket config should be set in .ssh/config for the $SSH_Host
	ssh -fNTM -L "$SQUID_PORT:localhost:$SQUID_PORT" -D "$SOCKS_PORT" -i "$SSH_KEY_PATH" "$SSH_USER@$SSH_HOST"

	print_success "Tunnel Setup"
	print_warn "Please configure software to use the tunnel (e.g., Firefox) using HTTP(S) proxy on port $SQUID_PORT, and Socks5 proxy on $SOCKS_PORT"
else
	print_info "Iodine DNS tunnel interface detected. Tearing down SSH tunnel"
	# -T means don't allocate a ptty
	# -O means the control command to send (for the control socket)
	# 'exit' is the control command to terminate the connection
	ssh -TO exit "$SSH_HOST"
	print_success "SSH tunnel shutdown"

	# Find and tell iodine to quit
	print_info "Tearing down DNS tunnel/interface"
	sudo pkill iodine
	print_success "Iodine DNS tunnel/interface down"
fi
