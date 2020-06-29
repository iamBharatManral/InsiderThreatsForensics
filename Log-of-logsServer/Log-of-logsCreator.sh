#!/bin/bash
#if [ -s ~/remote/log/audit/audit.log ]
#then
 #   COUNT=$(wc -l ~/remote/log/audit/audit.log | awk '{print $1}')
#else
    COUNT=0
#fi
eventno=0
count=$(wc -l ~/remote/log/audit/audit.log | awk '{print $1}')

if [ "$count" -gt "$COUNT" ]
then
	diff=`expr $count - $COUNT`
   	tail -n "$diff" ~/remote/log/audit/audit.log > ~/remote/log/audit/.temp
        eventno=`less ~/remote/log/audit/.temp | grep -f ~/remote/log/audit/patterns | awk '{print $3}' | cut -d : -f 2 | sed 's/)//'| head -n 1`
while [ ! -z "$eventno" ]
do
	grep -w "$eventno" ~/remote/log/audit/.temp | cat >> ~/remote/log/audit/LogOfLogs.log
        sed -i "/$eventno/d" ~/remote/log/audit/.temp
        eventno=`less ~/remote/log/audit/.temp | grep -f ~/remote/log/audit/patterns | awk '{print $3}' | cut -d : -f 2 | sed 's/)//'| head -n 1`
done
        COUNT=$count
fi
rm ~/remote/log/audit/.temp
/bin/ServiceStatusChecker

