#!/bin/bash
## Email address to receice report
REPORT_RECIPIENT="james.calver@serverchoice.com"

## Elastic server IP:PORT
ELASTIC="http://31.24.106.84:9211"

#================GLOBALS==================
RESPONSE=""
scriptname=""
#========================================

removetempfiles() {
	if [ -f "HistoricalIPSAlerts.csv" ]; then
		rm HistoricalIPSAlerts.csv
	fi
	if [ -f "NetworkConnections.csv" ]; then
		rm NetworkConnections.csv
	fi
	if [ -f "ResponseText.txt" ]; then
		rm ResponseText.txt
	fi
	if [ -f "EventText.txt" ]; then
		rm EventText.txt
	fi
}

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

#echo -e $QUERY
#The current days index is named logstash-YYYY-MM-DD
#Past indices are named logstash-company-YYYY-MM-DD


LOGNAME="test3.csv"
## Run query for ALD_IPS_Events
echo -e "\e[32m Fetching IPS Data\e[0m"
/home/jc/.local/bin/es2csv -u "$ELASTIC" -i logstash-"$CURRENT_DATE" -f @timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event -q "$QUERY" -o "$LOGNAME"

#cycle through all results
input="$LOGNAME"
while IFS=, read -r timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event
do

if [ -f "$LOGNAME" ]; then

	#the first line of the file is the headers, skip this.
	if [ "$src_ip" != 'src_ip' ]; then 

		#do processing
		#call IP LookUp Function to set RESPONSE variable
		echo -e "\e[32mCalling IPLookUP\e[0m"
		source /home/jc/Documents/AlertAutomation/IPLookUp.sh
		
		id=""		
		id="$(cat ResponseText.txt | jq '.[0].id')" 
		
		if [ "$id" = "\"Too Many Requests\"" ] ; then

			echo -e "\e[31m API rate limit exceeded\e[0m"
			mail -s "Aldermore IPS Alert" "$REPORT_RECIPIENT" <<< "API rate limit exceeded, conduct checks manually."
			echo "=Exiting Script="
			removetempfiles
			exit

		elif [ "$RESPONSE" != '[]' ]; then
			#Conduct Network Check
			echo -e "\e[32m Conducting Network Check\e[0m"
			source /home/jc/Documents/AlertAutomation/NetworkActivityCheck2.sh
		
			#check classification against ThreatDictionary.
			#if it is a known classification, construct email using existing template, if not send email to notify that a new template needs to be created.
			echo -e "\e[32mChecking Threat Dictionary\e[0m"
			source /home/jc/Documents/AlertAutomation/ThreatDictionary.sh
			#run relevant email creation script
			source "/home/jc/Documents/AlertAutomation/""$scriptname"
			#send email
			source /home/jc/Documents/AlertAutomation/SendMail.sh
		else
			#do nothing
			echo -e "No Events found"
		fi
	fi
fi
#introducing a delay so that API rate limit is not exceded.
sleep 1
#tidy
removetempfiles
done<"$input"


