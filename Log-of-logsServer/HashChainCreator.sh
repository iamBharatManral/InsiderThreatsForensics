#!/bin/bash

if [ "$2" == "audit" ]
then

	previous_count=$(wc -l ~/remote/log/audit/audit_hash_chain | awk '{print $1}')
	previous_count=`expr $previous_count / 2`
	previous_count=`expr $previous_count + 1`
	loop_count=$1
	while [ $loop_count != "0" ]
	do
		echo `date` >> ~/remote/log/audit/audit_hash_chain
		head -n "$previous_count" ~/remote/log/audit/audit.log | md5sum | cat >> ~/remote/log/audit/audit_hash_chain
		loop_count=`expr $loop_count - 1`
		previous_count=`expr $previous_count + 1`
	done
fi

if [ "$2" == "syslog.log" ]
then

	previous_count=$(wc -l ~/remote/log/syslog_hash_chain | awk '{print $1}')
        previous_count=`expr $previous_count / 2`
        previous_count=`expr $previous_count + 1`
        loop_count=$1
	echo $loop_count
        while [ $loop_count != "0" ]
        do
		echo `date` >> ~/remote/log/syslog_hash_chain
                head -n "$previous_count" ~/remote/log/syslog | md5sum | cat >> ~/remote/log/syslog_hash_chain
                loop_count=`expr $loop_count - 1`
                previous_count=`expr $previous_count + 1`
		
        done
fi

if [ "$2" == "auth" ]
then
	previous_count=$(wc -l ~/remote/log/auth_hash_chain | awk '{print $1}')
        previous_count=`expr $previous_count / 2`
        previous_count=`expr $previous_count + 1`
        loop_count=$1
        echo $loop_count
        while [ $loop_count != "0" ]
        do
                echo `date` >> ~/remote/log/auth_chain
                head -n "$previous_count" ~/remote/log/auth.log | md5sum | cat >> ~/remote/log/auth_hash_chain
                loop_count=`expr $loop_count - 1`
                previous_count=`expr $previous_count + 1`

        done
fi

