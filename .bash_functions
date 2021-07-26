#!/usr/bin/env bash

function print_status {
	local esc="\033["

	local reset="${esc}0m"
	local bold="${esc}1m"
	local green="${esc}92m"
	local red="${esc}91m"
	local yellow="${esc}93m"
	local blue="${esc}96m"

	echo -e "${bold}${!1}[${2}${reset}${!1}${bold}]${reset} ${3}"
}

function print_success {
	print_status "green" "+" "${1}!"
}

function print_info {
	print_status "blue" "*" "${1}..."
}

function print_error {
	print_status "red" "-" "${1}!"
}

function print_warn {
	print_status "yellow" "!" "${1}."
}

export -f print_status
export -f print_warn
export -f print_error
export -f print_success
export -f print_info

