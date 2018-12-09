#!/bin/bash
#requires installation of jq
#variables called from AldermoreIPSChecker
#timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event

if
COUNTRY="$(cat ResponseText.txt | jq '.[0].country')" &&
WHITELIST="$(cat ResponseText.txt | jq '.[0].isWhitelisted')" &&
ID="$(cat ResponseText.txt | jq '.[0].id')"; 
then
	echo "done"
else
COUNTRY="$(cat ResponseText.txt | jq '.country')" 
WHITELIST="$(cat ResponseText.txt | jq '.isWhitelisted')" 
ID="$(cat ResponseText.txt | jq '.id')"
	echo "done2"
fi

if [ "$ID" != 'Too Many Requests' ]; then 

echo -e "Event to raise">>EventText.txt
echo -e "==============================">>EventText.txt

echo -e "At the above stated time our SIEM detected malicious traffic originating from Source IP" "$src_ip" ", targeting Host IP "$dst_ip" "over port"$dst_port" ".">>EventText.txt
	#The above variables are populated from the initial read in of the tempcsv that is used to store log info. Read in during IP lookup.
echo -e "The traffic carries the signature of a network trojan and as a result was blocked. The Source IP is from"$COUNTRY" ", its whitelist status is "$WHITELIST" ". It has previously been reported for various malicious activities.">>EventText.txt
	#These varibles will need to be populated from the response text. It does not appear that the domain is provided by the response text, instead report whether it is whitelisted.
echo -e "Checking traffic between the Source IP and the Aldermore network reveals that this is the" "$NUMCONN" " instance of attempted communications.">>EventText.txt
echo -e "This is the" "$NUMIPS" "instance of the Source IP triggering an IPS alert">>EventText.txt
echo -e "==============================">>EventText.txt

#echo -e "$timestamp" 
#echo -e "$detection_ip"
#echo -e "$classification" 

else
	echo -e "Too many requests"

fi	
