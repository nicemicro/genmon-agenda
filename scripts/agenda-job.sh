#!/bin/bash

# Check for the existing cache directory. If there isn't one, create it.
if [ "$XDG_CACHE_HOME" != "" ]; then
	CACHEDIR="$XDG_CACHE_HOME/genmon-agenda"
else
	CACHEDIR="$HOME/.cache/genmon-agenda"
fi
if [ ! -d "$CACHEDIR" ]; then
	mkdir "$CACHEDIR"
fi

# Sync the vdirs
vdirsyncer sync

# Write the calendar items into a cache file
khal --color list now 1d > "$CACHEDIR/calendar"

# Write the todoman task items into a cache file
TODOLIST=$(todo --color always list --due 36 --startable --no-reverse)
if [ $( echo $TODOLIST | wc -w) != 0 ]; then
	echo "$TODOLIST" | sed -e 's/\[ \] [0-9]*[ ]*//' > $CACHEDIR/todo
else
	printf "" > $CACHEDIR/todo
fi
HIGHPR=$(todo list --priority high | sed -s "/^$/d" | wc -l)
if [ $HIGHPR != 0 ]; then
	HIGHPRNOW=$(todo list --priority high --due 36 | sed -s "/^$/d" | wc -l)
	if [ $(( $HIGHPR - $HIGHPRNOW )) != 0 ]; then
		echo $(tput bold)$(tput setaf 5) !!! +$(( $HIGHPR - $HIGHPRNOW ))\
			high priority $(tput sgr0)tasks not due in 36 hours. Use the \
			command \`todo\` to see more. >> $CACHEDIR/todo
	fi
fi
