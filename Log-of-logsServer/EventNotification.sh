#!/bin/bash
Subject="Alert From Log-of-logs Server"
From="lolServer@domain.com"
To="executive1@domain.com"
Body1="It is an email notification regarding changes in audit log file in Admin server, detected by Log-of-logs server"
Body2="It is an email notification regarding changes in syslog log file in Admin server, detected by Log-of-logs server"

if [ "$1" == "audit.log" ]; then
	echo $Body1
	echo $Body1 | mail -s $Subject $To 
fi

if [ "$1" == "syslog" ]; then
	echo $Body2
	echo $Body2 | mail -s $Subject $To  
fi
