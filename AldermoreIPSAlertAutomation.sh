#!/bin/bash
## Email address to receice report
REPORT_RECIPIENT="@serverchoice.com"

## Elastic server IP:PORT
ELASTIC="http://31.24.106.84:9211"

CURRENT_DATE="$(date -u +%Y.%m.%d)"
YESTERDAY="$(date -dyesterday +%Y.%m.%d)"
#make daterange
QUERYDATE="$(date -u +%Y-%m-%d)"
QUERYTIME="$(date +%H:%M:%S)"
TWOHOURSAGO="$(date -d '2 hours ago' +%H:%M:%S)"
QUERYDATETIME="$QUERYDATE"T"$QUERYTIME"Z
QUERYDATETIME2="$QUERYDATE"T"$TWOHOURSAGO"Z
DATERANGE="@timestamp: [""$QUERYDATETIME2"" TO ""$QUERYDATETIME""]"

QUERY="(syslog_program: \"AldermoreIPS\" !event: (\"APP-DETECT Teamviewer remote connection attempt\" OR \"OS-WINDOWS Microsoft Windows getbulk request attempt\" OR \"SERVER-IIS Microsoft IIS 7.5 client verify null pointer attempt\" OR \"INDICATOR-COMPROMISE DNS request for known malware sinkhole domain\") !dst_port: \"10190\") AND ""$DATERANGE"

#remove existing responsetext.txt doc - commented out for testing
#echo -e "Removing Old Reponse File"
#rm ResponseText.txt

echo -e $QUERY

LOGNAME="test3.csv"
## Run query for ALD_IPS_Events
echo -e "\e[32m Fetching IPS Data\e[0m"
/home/jc/.local/bin/es2csv -u "$ELASTIC" -i logstash-aldermore-"$CURRENT_DATE" -f @timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event -q "$QUERY" -o "$LOGNAME"
## Add all reports to a single file with the current date
#zip aldermore-daily-reports-$YESTERDAY.zip VPN*

declare -A EventDictionary

EventDictionary=([SERVER-APACHE Apache Struts remote code execution attempt]="Script1" [SERVER-ISS Microsoft ASP.NET bas request denial of service attempt]="Script2" [A Network Trojan was Detected]="Script3")

#echo -e "${EventDictionary[SERVER-APACHE Apache Struts remote code execution attempt]}"

if [ -f "$LOGNAME" ]; then
	#do processing
	APIKey="ttmW5n6Zh4QITCO2U7r75FX4wxWYRS7Cf90RwDSn"
	input="$LOGNAME"

	while IFS=, read -r timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event
	do
		echo -e "$src_ip"
		#dont bother doing request on file header
		if [ "$src_ip" != 'src_ip' ]; then 
			#the below has been commented out only for testing
			#RESPONSE="$(/usr/bin/curl "https://www.abuseipdb.com/check/""$src_ip""/json?key=""$APIKEY")"
			#echo "$RESPONSE">>ResponseText.txt
			#The below is an example for a clean result, for testing only, delete after.
			#RESPONSE="$(/usr/bin/curl "https://www.abuseipdb.com/check/94.126.41.33/json?key=""$APIKEY")"			 
			echo -e $RESPONSE
			#if response is not empty, do further processing. Need to write a check to see if rate limit has been reached as this will return an error rather than an empty response.
			if [ "$RESPONSE" != '[]' ]; then

			#further processing.
			#check classification against list of known classifications.

				#if it is a known classification, construct email using existing template
				if [[ -v EventDictionary["$classification"] ]]; then 
					echo -e "key found"
					#run relevant script to generate email text and send.
					source /home/jc/Documents/AlertAutomation/Script1.sh
				else
					echo -e "key not found"
					#run email to inform that a new IPS alert has been detected, a new key, 					email and script will need to be written.
				fi
		
		fi
	fi

	done<"$input"

else
	#do nothing
	echo -e "No Events found"
fi


# Send the zip file containing all reports to SOC so they can start writing up the actual report
#echo -e "Aldermore daily reports for day $YESTERDAY. The date of extraction is $CURRENT_DATE\n\nPlease double check and compile the report that will be sent to the customer" | mail -A aldermore-daily-reports-$YESTERDAY.zip -s "Aldermore Daily Reports" $REPORT_RECIPIENT

#echo -e "\e[32mReports have been exrtacted and sent to $REPORT_RECIPIENT. Please double check and compile the report that will be sent to the customer\e[0m"

## Cleanup old reports and zip files
#rm VPN* aldermore-daily-reports-$YESTERDAY.zip

## randasdfsda
