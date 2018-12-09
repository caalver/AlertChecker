#!/bin/bash
## Email address to receice report
REPORT_RECIPIENT="james.calver@serverchoice.com"

## Elastic server IP:PORT
ELASTIC="http://31.24.106.84:9211"

#================GLOBALS==================
RESPONSE=""
scriptname=""
#========================================


CURRENT_DATE="$(date -u +%Y.%m.%d)"
YESTERDAY="$(date -dyesterday +%Y.%m.%d)"
#make daterange
QUERYDATE="$(date -u +%Y-%m-%d)"
QUERYTIME="$(date +%H:%M:%S)"
TWOHOURSAGO="$(date -d '4 hours ago' +%H:%M:%S)"
QUERYDATETIME="$QUERYDATE"T"$QUERYTIME"Z
QUERYDATETIME2="$QUERYDATE"T"$TWOHOURSAGO"Z
DATERANGE="@timestamp: [""$QUERYDATETIME2"" TO ""$QUERYDATETIME""]"

#QUERY="(syslog_program: \"AldermoreIPS\" !event: (\"APP-DETECT Teamviewer remote connection attempt\" OR \"OS-WINDOWS Microsoft Windows getbulk request attempt\" OR \"SERVER-IIS Microsoft IIS 7.5 client verify null pointer attempt\" OR \"INDICATOR-COMPROMISE DNS request for known malware sinkhole domain\") !dst_port: \"10190\") AND ""$DATERANGE"

QUERY="syslog_program: \"AldermoreIPS\" AND ""$DATERANGE"

echo $DATERANGE

echo $QUERY

LOGNAME="querytest.csv"
## Run query for ALD_IPS_Events
echo -e "\e[32m Fetching IPS Data\e[0m"
/home/jc/.local/bin/es2csv -u "$ELASTIC" -i logstash-aldermore-"$CURRENT_DATE" -f @timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event -q "$QUERY" -o "$LOGNAME"
## Add all reports to a single file with the current date
#zip aldermore-daily-reports-$YESTERDAY.zip VPN*




