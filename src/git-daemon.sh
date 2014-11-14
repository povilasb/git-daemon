#!/bin/sh

### BEGIN INIT INFO
# Provides:          git-daemon
# Required-Start:    $local_fs $remote_fs $network $syslog $named $time
# Required-Stop:     $local_fs $remote_fs $network $syslog $named $time
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts git daemon
# Description: starts git daemon
### END INIT INFO


PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="git daemon"
NAME=git-daemon
SCRIPTNAME=/etc/init.d/$NAME


main()
{
	case "$1" in
		start)
			do_start
			;;
		stop)
			do_stop
			;;
		restart)
			do_reload
			;;
		status)
			do_status
			;;
		*)
			echo "Usage: $SCRIPTNAME {start|stop|restart|status}" >&2
			exit 3
			;;
	esac

	exit 0
}


do_start()
{
	[ "$VERBOSE" != no ] && echo "Starting $DESC" "$NAME"
	git daemon --reuseaddr --base-path=/home/git/repositories/ /home/git/repositories &
}


do_stop()
{
	[ "$VERBOSE" != no ] && echo "Stopping $DESC" "$NAME"
	killall git-daemon
}


do_reload()
{
	echo "Restarting $DESC" "$NAME"
	do_stop
	do_start
}


#
# Prints CenTux trannsport agent daemon status.
#
do_status()
{
	print_running_status "git daemon"
}


print_running_status()
{
	proc_name=$1
	echo -n "$1 is "

	is_process_running "$1"
	running=$?
	if [ $running -eq 1 ]; then
		echo "running."
	else
		echo "not running."
	fi
}


#
# First parameter is a process name pattern. E.g. it might be "script.py".
# Returns 1 if the specified process is running. Otherwise 0 is returned.
#
is_process_running()
{
	pattern="$1"
	process_count=`ps au | grep "$1" | wc -l`
	if [ $process_count -ge 2 ]; then
		return 1
	fi

	return 0
}


main "$@"
