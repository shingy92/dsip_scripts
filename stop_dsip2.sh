#!/bin/bash
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/sbin:/sbin
HOME=/
 
if [[ "$(service kamailio status)" == *"active (running)"* ]]; then
  echo  "Kamailio is Running, continuing with script"

COUNTER=0
REPLICA_IP="1.1.1.1"
ACTIVE_LINE_THESHOLD=10

REG_TRUNK_LIST="
+xxxxxxxxxxxx@xxxx.com
+xxxxxxxxxxxx@xxxx.com
"

INBOUND_TRUNK_IP_LIST="
xxxxxxxxx/32
xxxxxxxxxx/32
"

  for trunk in $REG_TRUNK_LIST
  do

    if [[ "$(kamcmd uac.reg_info auth_username $trunk)" = *"flags: 20"* ]]; then
      let COUNTER++
    fi

  done

  if (($COUNTER <= $ACTIVE_LINE_THESHOLD)); then
    service kamailio stop

    for inbound_ip in $INBOUND_TRUNK_IP_LIST
    do
      ufw deny from $inbound_ip
      wait
      ufw deny to $inbound_ip
      wait
    done

    exec ./start_dsip2.sh &
    echo "Dsipuk1 is down, starting Dsipuk2"
  else
    echo "ALL is currently fine" 
  fi  

fi 


