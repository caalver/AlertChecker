#!/bin/bash
#Sends email to report recipient 
echo "Sending mail to" "$REPORT_RECIPIENT"
mail -A EventText.txt -s "Aldermore IPS Alert" "$REPORT_RECIPIENT"



