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
+2638688007036@ims.telone.co.zw
+2638688007037@ims.telone.co.zw
+2638688007038@ims.telone.co.zw
+2638688007039@ims.telone.co.zw
+2638688007040@ims.telone.co.zw
+2638688007041@ims.telone.co.zw
+2638688007042@ims.telone.co.zw
+2638688007043@ims.telone.co.zw
+2638688007044@ims.telone.co.zw
+2638688007045@ims.telone.co.zw
+2638688007046@ims.telone.co.zw
+2638688007047@ims.telone.co.zw
"

INBOUND_TRUNK_IP_LIST="
167.86.72.12/32
72.167.39.12/32
173.212.243.200/32
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


