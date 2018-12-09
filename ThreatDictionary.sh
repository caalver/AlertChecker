#!/bin/bash
#sets global variable 'scriptname'

declare -A EventDictionary

EventDictionary=([SERVER-APACHE Apache Struts remote code execution attempt]="Script1" [SERVER-ISS Microsoft ASP.NET bas request denial of service attempt]="Script2" [A Network Trojan was Detected]="NetworkTrojanEmail.sh" [OS-OTHER Bash CGI environment variable injection attempt]="BashInjectionEmail.sh" [Attempted Administrator Privilege Gain]="AdminPrivilegeGain.sh")

#echo ${EventDictionary["A Network Trojan was Detected"]}

echo "classification=""$classification"


#check classification against list of known classifications.
#if it is a known classification, construct email using existing template
if [[ -v EventDictionary["$classification"] ]]; then 
	echo -e "key found"
	#run relevant script to generate email text and send.
	scriptname=$(echo ${EventDictionary["$classification"]})
	
	#the script shall be run by the main process using scriptname global.
	#source "/home/jc/Documents/AlertAutomation/""$scriptname"
else
	echo -e "key not found"
	#run email to inform that a new IPS alert has been detected, a new key, 					email and script will need to be written.
	scriptname="NewEntryRequired.sh"
fi
		







