## Elastic server IP:PORT
ELASTIC="http://31.24.106.84:9211"

CURRENT_DATE="$(date -u +%Y-%m-%d)"
#OLDDATE="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -25 day")"

dates[0]="$CURRENT_DATE"
echo -e "current date is" "${dates[0]}"
echo -e "source IP to check is" "$src_ip"


#this functions creates the indices to use in the query.
make_indices() {
#current days index has a different naming convention
if [ "$1" = 0 ] 
then
	dates["$1"]="$(date -u +%Y-%m-%d -d "$CURRENT_DATE - $1 day")"
	dates["$1"]=$(echo "${dates["$1"]}" | sed -r 's/[-]+/./g')
	indices["$1"]=$(echo "logstash-""${dates["$1"]}")
fi

dates["$1"]="$(date -u +%Y-%m-%d -d "$CURRENT_DATE - $1 day")"
dates["$1"]=$(echo "${dates["$1"]}" | sed -r 's/[-]+/./g')
indices["$1"]=$(echo "logstash-aldermore-""${dates["$1"]}")
}

count=0
while [ $count -lt 25 ]; do
	make_indices "$count"
#	echo "${dates["$count"]}"	
#	echo "${indices["$count"]}"
	let count=$count+1
done

#test
#src_ip="149.202.175.8"

QUERY="$src_ip"

LOGNAME="NetworkConnections.csv"
## Run query for NetworkConnections - limited to 5000 for testing
echo -e "\e[32m Fetching Network Connections Data\e[0m"
echo -e "Indices[0]=""${indices[0]}"

/home/jc/.local/bin/es2csv -m 5000 -u "$ELASTIC" -i "${indices[0]}" "${indices[1]}" "${indices[2]}" "${indices[3]}" "${indices[4]}" "${indices[5]}" "${indices[6]}" "${indices[7]}" "${indices[8]}" "${indices[9]}" "${indices[10]}" "${indices[11]}" "${indices[12]}" "${indices[13]}" "${indices[14]}" "${indices[15]}" "${indices[16]}" "${indices[17]}" "${indices[18]}" "${indices[19]}" "${indices[20]}" "${indices[21]}" "${indices[22]}" "${indices[23]}" "${indices[24]}" -f @timestamp message -q "$QUERY" -o "$LOGNAME"


NUMCONN=$(cat "$LOGNAME" | wc -l)
let NUMCONN-=1
let NUMCONN/=2
echo -e "number of connections made to aldermore network by IP is " "$NUMCONN"

#If NUMCONN is not 0/1 then do further processing.
	#list days that connections were made on.

if [ "$NUMCONN" -gt 1 ]
then
	
	## Query for IPS triggers
	QUERY="(\"$src_ip\" AND syslog_program: \"AldermoreIPS\") NOT event: \"INDICATOR-COMPROMISE DNS request for known malware sinkhole domain\" NOT event: \"APP-DETECT Teamviewer remote connection attempt\" NOT dst_port: \"10190\" NOT event: \"OS-WINDOWS Microsoft Windows getbult request attempt\" event: \"SERVER-IIS Microsoft IIS 7.5 client verify null pointer attempt\""
	
	LOGNAME="HistoricalIPSAlerts.csv"
	## Run query for HistoricalIPSAlerts
	echo -e "\e[32m Fetching IPS Data\e[0m"
	/home/jc/.local/bin/es2csv -u "$ELASTIC" -i "${indices[0]}" "${indices[1]}" "${indices[2]}" "${indices[3]}" "${indices[4]}" "${indices[5]}" "${indices[6]}" "${indices[7]}" "${indices[8]}" "${indices[9]}" "${indices[10]}" "${indices[11]}" "${indices[12]}" "${indices[13]}" "${indices[14]}" "${indices[15]}" "${indices[16]}" "${indices[17]}" "${indices[18]}" "${indices[19]}" "${indices[20]}" "${indices[21]}" "${indices[22]}" "${indices[23]}" "${indices[24]}" -f @timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event -q "$QUERY" -o "$LOGNAME"

	NUMIPS=$(cat "$LOGNAME" | wc -l)
	if [ "$NUMIPS" -gt 0 ] 
	then
		let NUMIPS-=1
	fi
	echo -e "number of IPS alerts triggered by IP is " "$NUMIPS"
fi



