#!/bin/bash
#RETURNS JSON Response


APIKey="ttmW5n6Zh4QITCO2U7r75FX4wxWYRS7Cf90RwDSn"
input="$LOGNAME"

#while IFS=, read -r timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event
#do
	echo -e "$src_ip"
	#dont bother doing request on file header
	if [ "$src_ip" != 'src_ip' ]; then 
		#the below has been commented out only for testing
		RESPONSE="$(/usr/bin/curl "https://www.abuseipdb.com/check/""$src_ip""/json?key=""$APIKEY")"
		#echo "$RESPONSE">>ResponseText.txt
		#The below is an example for a clean result, for testing only, delete after.
		#RESPONSE="$(/usr/bin/curl "https://www.abuseipdb.com/check/94.126.41.33/json?key=""$APIKEY")"			 
		echo -e "$RESPONSE">>ResponseText.txt
		#if response is not empty, do further processing. Need to write a check to see if rate limit has been reached as this will return an error rather than an empty response.
	fi

#done<"$input"


