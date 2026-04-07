#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# for multimonitor
old_ifs="$IFS"
IFS=$'\n'
for monitor_string in $(polybar --list-monitors); do
	case "$monitor_string" in
		*"(primary)"*)
			bar_name="primary";;
		*)
			bar_name="secondary";;
	esac

	# bar_name="secondary"
	# if [ $(echo "$monitor_string" | grep "(primary)") != "" ]; then
	# 	bar_name="primary"
	# fi

	monitor=$(echo "$monitor_string" | cut -d":" -f1)
	MONITOR=$monitor polybar --reload $bar_name & disown
	echo "MONITOR=$monitor polybar --reload $bar_name & disown" >> /tmp/polybar_launch.log
done
IFS="$old_ifs"
