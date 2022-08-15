#!/bin/bash
# configuration
FG="white" # default foreground colour
EXPIRED="red" # expired task color
URGENT="yellow" # due in 36 hours
PRIOR="purple" # high priority

DUEALREADY=$(todo list --due 1 | sed -s "/^$/d" | wc -l) # Due in an hour
DUENEXT=$(todo list --due 36 --startable | sed -s "/^$/d" | wc -l) # Due in 36 hours
ALL=$(todo list --startable | sed -s "/^$/d" | wc -l) # All open tasks
HIGHPR=$(todo list --priority high | sed -s "/^$/d" | wc -l) # High priority tasks

printf "<txt> "
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

printf "<tool>"
	todo --humanize list --startable --no-reverse --sort due \
		| sed -e 's/\[ \] [0-9]*[ ]*//'
echo "</tool>"
