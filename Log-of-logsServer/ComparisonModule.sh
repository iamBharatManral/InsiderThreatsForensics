#!/bin/bash
if [ -f ~/remote/config/rsyslog.conf.copy ]; then
diff ~/remote/config/rsyslog.conf ~/remote/config/rsyslog.conf.copy | grep ">\|<" | cut -c 3- >  ~/remote/config/.temp

	if [ -s ~/remote/config/.temp ]
	then
		echo `date` >> ~/remote/config/rsyslog.conf.change
		cat ~/remote/config/.temp >> ~/remote/config/rsyslog.conf.change
		rm ~/remote/config/.temp
		rm ~/remote/config/rsyslog.conf.copy

	else
		echo `date` >> ~/remote/config/rsyslog.conf.change
		echo "No Changes" >> ~/remote/config/rsyslog.conf.change
		rm ~/remote/config/rsyslog.conf.copy
	fi
fi

if [ -f ~/remote/config/auditd.conf.copy ]; then
	diff ~/remote/config/auditd.conf ~/remote/config/auditd.conf.copy | grep ">\|<" | cut -c 3- >> ~/remote/config/.temp
	if [ -s ~/remote/config/.temp ] 
	then
		echo `date` >> ~/remote/config/audit.conf.change
        	cat ~/remote/config/.temp >> ~/remote/config/audit.conf.change
	        rm ~/remote/config/.temp
		rm ~/remote/config/audit.conf.copy
	else
		echo `date` >> ~/remote/config/audit.conf.change
                echo "No Changes" >> ~/remote/config/audit.conf.change
		rm ~/remote/config/rsyslog.conf.copy
	fi
fi

if [ -f ~/remote/config/audit.rules.copy ]; then
	diff ~/remote/config/audit.rules ~/remote/config/audit.rules.copy | grep ">\|<" | cut -c 3- >> ~/remote/config/.temp
	if [ -s ~/remote/config/.temp ]
	then	
		echo `date` >> ~/remote/config/audit.rules.change
		cat ~/remote/config/.temp >> ~/remote/config/audit.rules.change
		rm ~/remote/config/.temp
		rm ~/remote/config/audit.rules.copy
	else
		echo `date` >> ~/remote/config/audit.rules.change
                echo "No Changes" >> ~/remote/config/audit.rules.change
	fi
fi
