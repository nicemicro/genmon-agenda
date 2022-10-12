#!/bin/bash
# configuration
TERMINAL="st -e" # the terminal application to use
FG="white" # default foreground colour
EXPIRED="red" # expired task color
URGENT="yellow" # due in 36 hours
PRIOR="purple" # high priority

# Due in an hour
DUEALREADY=$(todo list --due 1 | sed -s "/^$/d" | wc -l)
# Due in 36 hours
DUENEXT=$(todo list --due 36 --startable | sed -s "/^$/d" | wc -l)
# All open tasks
ALL=$(todo list --startable | sed -s "/^$/d" | wc -l)
# High priority tasks
HIGHPR=$(todo list --priority high | sed -s "/^$/d" | wc -l)

# text in the xfce4 bar
printf "<txt> <span foreground='%s'>Tasks: </span>" $FG
if [ $DUEALREADY != 0 ]; then
	printf "<span foreground='%s'>%d</span>" $EXPIRED $DUEALREADY
	printf "<span foreground='%s'> | </span>" $FG
fi
if [ $(( $DUENEXT - $DUEALREADY )) != 0 ]; then
	printf "<span foreground='%s'>%d</span>" $URGENT $(( $DUENEXT - $DUEALREADY ))
	printf "<span foreground='%s'> | </span>" $FG 
fi
printf "<span foreground='%s'>%d</span>" $FG $ALL
if [ $HIGHPR != 0 ]; then
	printf "<span foreground='%s'> (</span>" $FG
	printf "<span foreground='%s'>!%d!</span>" $PRIOR $HIGHPR
	printf "<span foreground='%s'>)</span>" $FG
fi

printf " </txt>\n"

# what happens on click
echo "<txtclick>$TERMINAL $HOME/bin/genmon-agenda/scripts/todoman-interactive.sh</txtclick>"

# tooltip
printf "<tool>"
	todo --humanize list --startable --no-reverse --sort due \
		| sed -e 's/\[ \] [0-9]*[ ]*//'
echo "</tool>"
