#!/bin/bash
if [ -s ~/remote/log/audit/audit.log ]
then
   COUNT1=$(wc -l ~/remote/log/audit/audit.log | awk '{print $1}')
else
    COUNT1=0
fi

if [ -s ~/remote/log/syslog ]
then
   COUNT2=$(wc -l ~/remote/log/syslog | awk '{print $1}')
else
    COUNT2=0
fi

while status=`inotifywait -q -e modify -r ~/remote/`;
do
	filepath=$status
	filename=`echo $filepath | awk '{print $3}'`
	if [[ $filename == "audit" ]]; then
			diff ~/remote/log/audit/audit.log ~/remote/log/audit/audit | grep ">" | cut -c 3- >> ~/remote/log/audit/audit.log
			count=$(wc -l ~/remote/log/audit/audit | awk '{print $1}')
			hash1=`md5sum ~/remote/log/audit/audit.log | awk '{print $1}'`
	                hash2=`md5sum ~/remote/log/audit/audit | awk '{print $1}'`
                	if [ "$hash1" == "$hash2" ]
                	then
				diffr=`expr $count - $COUNT1`
				/bin/LogOfLogsCreator
	        	        /bin/HashChainCreator $diffr $filename
				rm ~/remote/log/audit/audit
			else
				date | cat >> ~/remote/log/audit/audit_MissingEntries
				diff ~/remote/log/audit/audit.log ~/remote/log/audit/audit | grep "<" | cut -c 3- >> ~/remote/log/audit/audit_MissingEntries
        	                rm ~/remote/log/audit/audit
				diffr=`expr $count - $COUNT1`
				/bin/LogOfLogsCreator
				/bin/HashChainCreator $diffr $filename
				/bin/EventNotification $filename
			fi
	fi
	if [[ $filename == "syslog.log" ]]; then
		diff ~/remote/log/syslog ~/remote/log/syslog.log | grep ">" | cut -c 3- >> ~/remote/log/syslog
                        count=$(wc -l ~/remote/log/syslog | awk '{print $1}')
                        hash1=md5sum ~/remote/log/syslog
                        hash2=md5sum ~/remote/log/syslog.log
                        if [ "$hash1" == "$hash2" ]
                        then
				diffr=`expr $count - $COUNT2`
                                /bin/HashChainCreator $diffr $filename
				rm ~/remote/log/syslog.log
                        else
                                date | cat >> ~/remote/log/syslog_MissingEntries
                                diff ~/remote/log/syslog ~/remote/log/syslog.log | grep "<" | cut -c 3- >> ~/remote/log/syslog_MissingEntries
                                rm ~/remote/log/syslog.log
                                diffr=`expr $count - $COUNT1`
                                /bin/HashChainCreator $diffr $filename
				/bin/EventNotification $filename
			fi
	fi
	if [[ $filename == "auditd.conf.copy" ]] || [[ $filename == "rsyslog.conf.copy" ]] || [[ $filename == "audit.rules.copy" ]]; then
		/bin/ComparisonModule
	fi

	if [[ $filename == "auth" ]]; then
                diff ~/remote/log/auth.log ~/remote/log/auth | grep ">" | cut -c 3- >> ~/remote/log/auth.log
                        count=$(wc -l ~/remote/log/auth.log | awk '{print $1}')
                        hash1=md5sum ~/remote/log/auth.log
                        hash2=md5sum ~/remote/log/auth
                        if [ "$hash1" == "$hash2" ]
                        then
                                diffr=`expr $count - $COUNT2`
                                /bin/HashChainCreator $diffr $filename
                                rm ~/remote/log/auth
                        else
                                date | cat >> ~/remote/log/authlog_MissingEntries
                                diff ~/remote/log/auth ~/remote/log/auth | grep "<" | cut -c 3- >> ~/remote/log/authlog_MissingEntries
                                rm ~/remote/log/auth
                                diffr=`expr $count - $COUNT1`
                                /bin/HashChainCreator $diffr $filename
                                /bin/EventNotification $filename
                        fi
        fi
	if [[ $filename == "auth" ]]; then
		cat ~/remote/log/audit/logentry >> ~/remote/log/audit/LogOfLogs.log
		event=`cat ~/remote/log/audit/logentry`
		/bin/EventNotification $event
		rm ~/remote/log/audit/logentry
	fi
	
	if [[ $filename == ".no_update" ]]; then
		echo `date` >> ~/remote/log/audit/LogOfLogs.log
		cat ~/remote/log/.no_update >> ~/remote/log/audit/LogOfLogs.log
	fi
done



