## Elastic server IP:PORT
ELASTIC="http://31.24.106.84:9211"

CURRENT_DATE="$(date -u +%Y-%m-%d)"
OLDDATE="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -25 day")"

date0=$(echo "$CURRENT_DATE" | sed -r 's/[-]+/./g')

date1="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -1 day")"
date1=$(echo "$date1" | sed -r 's/[-]+/./g')

date2="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -2 day")"
date2=$(echo "$date2" | sed -r 's/[-]+/./g')

date3="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -3 day")"
date3=$(echo "$date3" | sed -r 's/[-]+/./g')

date4="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -4 day")"
date4=$(echo "$date4" | sed -r 's/[-]+/./g')

date5="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -5 day")"
date5=$(echo "$date5" | sed -r 's/[-]+/./g')

date6="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -6 day")"
date6=$(echo "$date6" | sed -r 's/[-]+/./g')

date7="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -7 day")"
date7=$(echo "$date7" | sed -r 's/[-]+/./g')

date8="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -8 day")"
date8=$(echo "$date8" | sed -r 's/[-]+/./g')

date9="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -9 day")"
date9=$(echo "$date9" | sed -r 's/[-]+/./g')

date10="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -10 day")"
date10=$(echo "$date10" | sed -r 's/[-]+/./g')

date11="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -11 day")"
date11=$(echo "$date11" | sed -r 's/[-]+/./g')

date12="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -12 day")"
date12=$(echo "$date12" | sed -r 's/[-]+/./g')

date13="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -13 day")"
date13=$(echo "$date13" | sed -r 's/[-]+/./g')

date14="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -14 day")"
date14=$(echo "$date14" | sed -r 's/[-]+/./g')

date15="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -15 day")"
date15=$(echo "$date15" | sed -r 's/[-]+/./g')

date16="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -16 day")"
date16=$(echo "$date16" | sed -r 's/[-]+/./g')

date17="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -17 day")"
date17=$(echo "$date17" | sed -r 's/[-]+/./g')

date18="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -18 day")"
date18=$(echo "$date18" | sed -r 's/[-]+/./g')

date19="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -19 day")"
date19=$(echo "$date19" | sed -r 's/[-]+/./g')

date20="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -20 day")"
date20=$(echo "$date20" | sed -r 's/[-]+/./g')

date21="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -21 day")"
date21=$(echo "$date21" | sed -r 's/[-]+/./g')

date22="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -22 day")"
date22=$(echo "$date22" | sed -r 's/[-]+/./g')

date23="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -23 day")"
date23=$(echo "$date23" | sed -r 's/[-]+/./g')

date24="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -24 day")"
date24=$(echo "$date24" | sed -r 's/[-]+/./g')

date25="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -25 day")"
date25=$(echo "$date25" | sed -r 's/[-]+/./g')

#date26="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -26 day")"
#date26=$(echo "$date26" | sed -r 's/[-]+/./g')

#date27="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -27 day")"
#date27=$(echo "$date27" | sed -r 's/[-]+/./g')

#date28="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -28 day")"
#date28=$(echo "$date28" | sed -r 's/[-]+/./g')

#date29="$(date -u +%Y-%m-%d -d "$CURRENT_DATE -29 day")"
#date29=$(echo "$date29" | sed -r 's/[-]+/./g')


#dates=($date29 $date28 $date27)

#for i in "${dates[@]}"
#do
#	echo $i
#	i=$(echo "$i" | sed -r 's/[-]+/./g')
#	echo $i
#done

#echo "changed?" "$date29"


#echo -e "CURRENT DATE =" "$CURRENT_DATE"
#echo -e "LAST MONTH =" "$OLDDATE"

#curr="$OLDDATE"
#enddate="$CURRENT_DATE"

#INDICES=""

#while true; do
#	echo "$curr"
#	formatted=$(echo "$curr" | sed -r 's/[-]+/./g')
#	INDICES="$INDICES logstash-aldermore-$formatted"
#	[ "$curr" \< "$enddate" ] || break
#	curr=$( date +%Y-%m-%d -d "$curr +1 day" )
#done

#echo "$INDICES"

#INDICES=$(echo "$INDICES" | sed -r 's/[-]+/./g')

#echo "$INDICES"

QUERY="$src_ip"

#test
QUERY="149.202.175.8"

LOGNAME="NetworkConnections.csv"
## Run query for NetworkConnections
echo -e "\e[32m Fetching IPS Data\e[0m"
/home/jc/.local/bin/es2csv -u "$ELASTIC" -i logstash-aldermore-"$date25" logstash-aldermore-"$date24" logstash-aldermore-"$date23" logstash-aldermore-"$date22" logstash-aldermore-"$date21" logstash-aldermore-"$date20" logstash-aldermore-"$date19" logstash-aldermore-"$date18" logstash-aldermore-"$date17" logstash-aldermore-"$date16" logstash-aldermore-"$date15" logstash-aldermore-"$date14" logstash-aldermore-"$date13" logstash-aldermore-"$date12" logstash-aldermore-"$date11" logstash-aldermore-"$date10" logstash-aldermore-"$date9" logstash-aldermore-"$date8" logstash-aldermore-"$date7" logstash-aldermore-"$date6" logstash-aldermore-"$date5" logstash-aldermore-"$date4" logstash-aldermore-"$date3" logstash-aldermore-"$date2" logstash-aldermore-"$date1" logstash-aldermore-"$date0" -f @timestamp detection_ip classification src_ip src_port dst_ip dst_port priority event -q "$QUERY" -o "$LOGNAME"
## Add all reports to a single file with the current date
#zip aldermore-daily-reports-$YESTERDAY.zip VPN*

NUMCONN=$(cat "$LOGNAME" | wc -l)

echo -e "$NUMCONN"

#If NUMCONN is not 0/1 then do further processing.
	#list days that connections were made on.



