#!/bin/sh
#On being called ensure connection to the internet is established. If not Login to TTN

notLogged=$(curl -s -L google.com| grep -c -i userportal)
if [ $notLogged -ne "0" ]
then
	echo "-------- $(date) --------" >> /home/looneygod/Workspace/TTN/TTNlogin.log
	refreshURL=$(curl -s -X GET 1.254.254.254 | grep "\"Refresh\""| cut -d "\"" -f4| cut -c7-)
	#curl -v -L -X POST --cookie "JSESSIONID=B202C44B8DDD253FFDF88AF88668BA96" --data "type=2&username=adithya301&password=qwertyuioP098&rememberme=" 'http://103.6.156.200/userportal/newlogin.do?phone=0' >> /home/looneygod/Workspace/TTN/TTNlogin.log
	curl -v -L -X GET --cookie-jar /home/looneygod/Workspace/TTN/TTNCookieJar $refreshURL && curl -v -L -X POST --cookie /home/looneygod/Workspace/TTN/TTNCookieJar --data "type=2&username=adithya301&password=qwertyuioP098&rememberme=" 'http://103.6.156.200/userportal/newlogin.do?phone=0' # >> /home/looneygod/Workspace/TTN/TTNlogin.log
	notLogged=$(curl -s -L google.com| grep -c -i userportal)
	if [ $notLogged -e "0" ]
	then
		echo "SUCCESSFULLY LOGGED AT $(date)" >> /home/looneygod/Workspace/TTN/TTNlogin.log
		echo "............................................." >> /home/looneygod/Workspace/TTN/TTNlogin.log
	else
		echo "Falied to login!!!"
	fi
else
	echo "Chumma tried at $(date)" >> /home/looneygod/Workspace/TTN/TTNlogin.log
fi
