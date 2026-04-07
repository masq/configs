#!/usr/bin/env bash
set -uo pipefail
set -e

# For debugging, uncomment this line
#set -x

main_player="spotify"
max_length=45
abbreviation_string=" ... "

# Takes a string and shortens it with an abbreviation string in the middle
# e.g., "something quite long" -> "somethin ... long"
abbreviate_string() {
	local string="$@"
	local count=$(echo "$string" | wc -m)

	# If it's less than the max length, return
	if [ $count -lt $max_length ]; then
		echo "$string"

	# If it's too long, take the beginning and end of the string with ellipses between and return
	else 
		local length="${#string}"
		local abbreviate_length=$(((${max_length}-${#abbreviation_string}) / 2))

		# Return first part of string, abbreviation string, last part of string
		echo -n "${string:0:${abbreviate_length}}"
		echo -n "${abbreviation_string}"
		echo -n "${string:${length}-${abbreviate_length}:${length}}"
	fi
}

# Get all active media players
players=$(playerctl -l)

# Check for the main player and set variable indicating it is.
set +e
echo -n "${players}" | grep "${main_player}" 2>&1 1>/dev/null; is_main_player_active="${?}"
set -e

# If we have the main player active...
if [ "${is_main_player_active}" -eq 0 ]; then
	# Get the artist, album, and title of that one.
	artist=$(playerctl -p "${main_player}" metadata --format '{{artist}}')
	album=$(playerctl -p "${main_player}" metadata --format '{{album}}')
	title=$(playerctl -p "${main_player}" metadata --format '{{title}}')

# Otherwise, just grab the first player / default player in the list's artist, album, title
else
	artist=$(playerctl metadata --format '{{artist}}')
	album=$(playerctl metadata --format '{{album}}')
	title=$(playerctl metadata --format '{{title}}')
fi

# If there's no artist for the track (e.g., Spotify audiobooks... they use album instead)
if [ -z "${artist}" ]; then
	# Then print the album instead, as in "<Album>: <Title>"
	echo -n "$(abbreviate_string ${album}): $(abbreviate_string ${title})"
else
	# Otherwise, we want to print "<Artist>: <Title>"
	echo -n "$(abbreviate_string ${artist}): $(abbreviate_string ${title})"
fi
