#!/usr/bin/env bash

set -e

print_info "Acquiring time using NTP to reset the clock"

sudo service ntp stop
sudo ntpd -gq
sudo service ntp start

print_success "Clock reset"
