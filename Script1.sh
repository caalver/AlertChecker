#!/bin/bash
#requires installation of jq
#variables called from AldermoreIPSChecker
#timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event

COUNTRY="$(cat ResponseText.txt | jq '.[0].country')"
WHITELIST="$(cat ResponseText.txt | jq '.[0].isWhitelisted')"
ID="$(cat ResponseText.txt | jq '.[0].id')"

if [ "$ID" != 'Too Many Requests' ]; then 

echo -e "Email to send"
echo -e "=============================="

echo -e "At the above stated time our SIEM detected malicious traffic originating from Source IP" "$src_ip" ", targeting Host IP "$dst_ip" "over port"$dst_port" "."
	#The above variables are populated from the initial read in of the tempcsv that is used to store log info. Read in during IP lookup.
echo -e "The traffic carries the signature of a network trojan and as a result was blocked. The Source IP is from"$COUNTRY" ", its whitelist status is "$WHITELIST" ". It has previously been reported for various malicious activities."
	#These varibles will need to be populated from the response text. It does not appear that the domain is provided by the response text, instead report whether it is whitelisted.
echo -e "Checking traffic between the Source IP and the Aldermore network reveals that this is the" "$VAR3" " instance of attempted communications."
	#This will need its own script that will do the following
	#Run query against 30 days log data for all traffic searching for the IP + Customer, count number of unique days. Provide count and list days.
	#Run query against 30 days log data for IPS alerts searching for the IP + customer, count number of hits. Provide count.

echo -e "=============================="

#echo -e "$timestamp" 
#echo -e "$detection_ip"
#echo -e "$classification" 

else
	echo -e "Too many requests"

fi	
