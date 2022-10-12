#/bin/bash

todo list

while true ; do
	echo
	echo "Command (press h for help): "
	read CMD
	case $CMD in
		"h" | "H")
			echo "l:	List todos"
			echo "s:	List startable todos"
			echo "n:	New todo"
			echo "e:	Edit todo"
			echo "d:	Delete todo"
			echo "q:	Quit"
			echo "Anything else gets executed as the parameters to the \"todo\" command"
			;;
		"l" | "L")
			todo list
			;;
		"s" | "S")
			todo list --startable
			;;
		"n" | "N")
			todo new
			;;
		"e" | "E")
			todo list
			echo
			echo "Enter the number of the todo to edit (c to cancel):"
			read CHOICE
			if [[ $CHOICE != "c" ]] && [[ $CHOICE != "C" ]]; then
				todo edit $CHOICE
			fi
			;;
		"d" | "D")
			todo list
			echo
			echo "Enter the number of the todo to delete (c to cancel):"
			read CHOICE
			if [[ $CHOICE != "c" ]] && [[ $CHOICE != "C" ]]; then
				todo delete $CHOICE
			fi
			;;
		"q" | "Q")
			exit
			;;
		*)
			todo $CMD
			;;
	esac
done
