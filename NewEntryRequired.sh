#!/bin/bash
#requires installation of jq
#variables called from AldermoreIPSChecker
#timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event

if [ "$ID" != 'Too Many Requests' ]; then 

echo -e "Event to raise">>EventText.txt
echo -e "==============================">>EventText.txt

echo -e "An IPS event has been detected that does not currently have an entry in the EventDirectory, please investigate this event and create a template.">>EventText.txt
echo -e "==============================">>EventText.txt

else
	echo -e "Too many requests"

fi	
