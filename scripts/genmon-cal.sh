#!/bin/bash
# configuration
TERMINAL="st -e" # the terminal application to use
FG="white" # foreground color
TODAY="yellow" # events today

RNDTEXT="jjjandosmdadijsajndsndad" # a random text to count events

# All events this day
DAY=$(khal list today 1d --once --format "$RNDTEXT" | grep "$RNDTEXT" | wc -l)
# All events this week
WEEK=$(khal list --once --format "$RNDTEXT" | grep "$RNDTEXT" | wc -l)


# text in the xfce4 bar
printf "<txt><span foreground='%s'> Events: </span>" $FG
printf "<span foreground='%s'> %d</span>" $TODAY $DAY
if [ $(( $WEEK - $DAY )) != 0 ]; then
	printf "<span foreground='%s'> | %d</span>" $FG $(( $WEEK - $DAY))
fi
printf " </txt>\n"

# what happens on click
echo "<txtclick>$TERMINAL ikhal</txtclick>"

# tooltip
echo "<tool>"
	khal list
echo "</tool>"
