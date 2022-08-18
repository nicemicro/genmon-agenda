#!/bin/bash

# Check for the existing cache directory. If there isn't one, create it.
if [ "$XDG_CACHE_HOME" != "" ]; then
	CACHEDIR="$XDG_CACHE_HOME/genmon-agenda"
else
	CACHEDIR="$HOME/.cache/genmon-agenda"
fi

if [ -f "$CACHEDIR/calendar" ]; then
	cat "$CACHEDIR/calendar"
	if [ -f "$CACHEDIR/todo" ]; then
		echo
	fi
fi

if [ -f "$CACHEDIR/todo" ]; then
	cat "$CACHEDIR/todo"
fi
