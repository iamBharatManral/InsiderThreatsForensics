#!/bin/bash
~/NoUpdateCounter&
while filepath=`inotifywait -q -e modify -e delete_self /var/log/syslog /var/log/audit/audit.log` ;
do
	file=`echo $filepath | awk '{print $1}'`
	event=`echo $filepath | awk '{print $2}'`
	if [ $file == "/var/log/audit/audit.log" ]
	then
			less /var/log/audit/audit.log | cat > ~/audit
                        scp ~/audit censerver@CentralizedServer:~/remote/log/audit/
                        rm ~/audit
	fi
	if [ $file == "/var/log/syslog" ]
	then
			less /var/log/syslog | cat > ~/syslog.log
                        scp ~/syslog.log censerver@CentralizedServer:~/remote/log/
                        rm ~/syslog.log
	fi
	if [ $file == "/var/log/auth.log" ]
	then
			less /var/log/auth.log | cat > ~/auth
                        scp ~/auth censerver@CentralizedServer:~/remote/log/
                        rm ~/auth
	fi
	if [ $event == "DELETE_SELF" ]
	then
		if [ $file == "/var/log/audit/audit.log" ]
		then
			echo "source=ForensicAgent machine=$hostname COMM=rm FILE=/var/log/audit/audit.log USER=$USER" > ~/logentry
			scp ~/logentry censerver@CentralizedServer:~/remote/log/audit/
			rm ~/logentry
		fi
	fi
done
