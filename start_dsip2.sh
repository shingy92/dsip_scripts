#!/bin/bash
 
INBOUND_TRUNK_IP_LIST="

"

sleep  8m
service kamailio restart
wait 

if [[ "$(service kamailio status)" == *"active (running)"* ]]; then
    sleep 2m      
    for inbound_ip in $INBOUND_TRUNK_IP_LIST
    do
        ufw allow from $inbound_ip
        #wait
        ufw allow to $inbound_ip
        #wait
    done

    echo "Dsipuk2 is now UP"
else
 echo "[URGENT] Failed to start Dsipuk1 after Dsipuk2 had failed ,Please check manually"
fi 

#rate limit kamailio for 5 minutes

