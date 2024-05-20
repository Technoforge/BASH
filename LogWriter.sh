#!/bin/bash
#
#Name: LogWriter.sh.
#Package: Awesome Script System.
#Purpose: Write logs.
#Parameters: [script it is called from] [user] [message].
#Author: Adam Webber.
#Date: 14 August 2019.
#

# Create LogDirectory variable and assign path.
LogDirectory='/var/log/ass'
Log='log'
Message=''
ShortMessage=''

# Check if LogDirectory does not exist.
if [ ! -d $LogDirectory ] 
then
	# If logs directory does not exist, then try to create logs directory.
	if [ ! mkdir $LogDirectory ]
	then
		Message="Failed to create directory $LogDirectory."
		ShortMessage="failed"
	else
		# Assign action message.
		Message="Created directory $LogDirectory."
		ShortMessage="succeeded"
		# Echo directory creation action to log.
		echo $(date +"%Y-%m-%d"),$(date +"%T"),$0,$2,$ShortMessage,"$Message" >> $LogDirectory/$Log
	fi
# If the output directory exists, then do this...
else
	# If LogDirectory exists, assemble and output log entry.
	ShortMessage="succeeded"
	echo $(date +"%Y-%m-%d"),$(date +"%T"),$1,$2,$ShortMessage,$3 >> $LogDirectory/$Log
	# Assign LogWriter outcome message.
	Message="Log write completed for $1."
	ShortMessage="succeeded"
	# Echo log write to log.
	echo $(date +"%Y-%m-%d"),$(date +"%T"),$0,$2,$ShortMessage,"$Message" >> $LogDirectory/$Log
fi
