#!/bin/bash
while true;
do	
	audit_mTime=`expr $(($(date +%s) - $( date +%s -r /var/log/audit/audit.log)))`
	syslog_mTime=`expr $(($(date +%s) - $( date +%s -r /var/log/syslog)))`
	audit_mTime=`expr $audit_mTime + 1`
	syslog_mTime=`expr $syslog_mTime + 1`
	if [ $audit_mTime -le 61 ] || [ $syslog_mTime -le 61 ]; then
		sleep 60s
	else 
		echo "No updates in last epoch for syslog and audit.log" | cat > ~/.no_update
		scp ~/.no_update censerver@CentralizedServer:~/remote/log/
		rm ~/.no_update
		sleep 60s
	fi
done
