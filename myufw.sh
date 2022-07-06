#!/bin/bash

IP_ACL="
"

sudo ufw disable
sudo ufw reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 2222
sudo ufw allow 5900

for ip in $IP_ACL
do
    ufw allow from $ip
    ufw allow to $ip
done

sudo ufw enable
