#!/bin/bash
syslogstatus=`ssh adminserver@AdServer systemctl is-active rsyslog.service`
auditstatus=`ssh adminserver@AdServer systemctl is-active auditd.service`
if [ "$syslogstatus" == "inactive" ]
then
	/bin/EventNotification $syslogstatus
fi

if [ "$auditstatus" == "inactive" ]
then
	/bin/EventNotification $auditstatus
fi
		

