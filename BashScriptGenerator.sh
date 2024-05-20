#!/bin/bash
#
# Name: BashScriptGenerator.sh.
# Package: Awesome Script System.
# Purpose: Generate BASH script template for the Awesome Script System.
# Parameters: The name of the script to create, with .sh extension.
# Author: Adam Webber.
# Date: 2019-10-28.
#

OUTPUT=NULL

if [[ -z "$1" ]]; then
	echo -n Enter a script name: 
	read FN
else
	FN=$1
fi

OUTPUT="#!/bin/bash\n#\n#Name: "$FN"\n#Package: Awesome Script System.\n#Purpose: \n#Parameters: \n#Author: Adam Webber.\n#Date: "$(date +%Y-%m-%d)"\n#\n\nif [[ -z \"\$1\" ]]; then\n\tDo something...\nelse\n\tDo something else...\nfi\n\n#Case statement.\ncase \$var in\n\tOption1)\n\t\tDo something...\n\t\t;;\n\t*)\n\t\tDo something else...\n\t\t;;\nesac\n\n#While loop.\nx=1\nwhile [ \$x -le 5 ]\ndo\n\tDo something...\n\tx=$(( $x +1 ))\ndone\n\n#For loop.\nfor i in {1..5}\ndo\n\tDo something...\ndone\n\n#File loop.\nfor file in /etc/*\ndo\n\tDo domething...\ndone\n\n/opt/ass/LogWriter.sh \$0 \$USER \"Message text \"\$SomeVariable\" message text.\""

echo -e $OUTPUT > $FN

/opt/ass/LogWriter.sh $0 $USER "BASH script "$FN" created."
