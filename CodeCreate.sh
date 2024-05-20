#!/bin/bash
#
#Name: CodeCreate.sh
#Package: Awesome Script System.
#Purpose: Generate templates for programming.
#Parameters: [filename.ext]
#Author: Adam Webber.
#Date: 2019-10-31
#

if [[ $# -ne 1 ]]; then
	echo "This script requires one parameter: file name with extension. Example: codecreate myfile.c.  Quitting now."
	/opt/ass/LogWriter.sh $0 $USER "Quitting due to incorrect parameter count."
	exit 1
else
	FN=$1
fi

#Create template based on parameters passed to script.
case "${FN##*.}" in
	sh)
		mkdir ~/Coding/Bash/${FN%.*}
		cd ~/Coding/Bash/${FN%.*}
		OUTPUT="#!/bin/bash\n#\n#Name: "$FN"\n#Package: Awesome Script System.\n#Purpose: \n#Parameters: \n#Author: Adam Webber.\n#Date: "$(date +%Y-%m-%d)"\n#\n\nif [[ -z \"\$1\" ]]; then\n\tDo something...\nelse\n\tDo something else...\nfi\n\n#Case statement.\ncase \$var in\n\tOption1)\n\t\tDo something...\n\t\t;;\n\t*)\n\t\tDo something else...\n\t\t;;\nesac\n\n#While loop.\nx=1\nwhile [ \$x -le 5 ]\ndo\n\tDo something...\n\tx=$(( $x +1 ))\ndone\n\n#For loop.\nfor i in {1..5}\ndo\n\tDo something...\ndone\n\n#File loop.\nfor file in /etc/*\ndo\n\tDo domething...\ndone\n\n/opt/ass/LogWriter.sh \$0 \$USER \$ErrorMessage"
		;;
	c)
		mkdir ~/Coding/C/${FN%.*}
		cd ~/Coding/C/${FN%.*}
		OUTPUT="#include <stdio.h>\n\nmain()\n{\n\tprintf(\"Hello world!\");\n\treturn 0;\n}"
		;;
	cpp)
		mkdir ~/Coding/C++/${FN%.*}
		cd ~/Coding/C++/${FN%.*}
		OUTPUT="#include <iostream>\n\nmain()\n{\n\tstd:cout << \"Hello world!\";\n\treturn 0;\n}"
		;;
	*)
		echo File extension not yet supported. Quitting now.
		/opt/ass/LogWriter.sh $0 $USER "Quitting due to unsupported file extension."
		exit 1
esac

#Create file.
echo -e $OUTPUT > $FN

#Write report line to log.
/opt/ass/LogWriter.sh $0 $USER "File "$FN" created."
