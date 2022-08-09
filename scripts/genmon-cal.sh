#!/bin/bash
# configuration
TERMINAL="st -e" # the terminal application to use
FG="white" # foreground colour

echo "<txt><span foreground='$FG'> Cal </span></txt>"
echo "<txtclick>$TERMINAL ikhal</txtclick>"
echo "<tool>"
	khal list now sunday
echo "</tool>"
