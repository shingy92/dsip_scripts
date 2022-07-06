#!/bin/bash

IP_ACL="
197.221.224.35/32
167.86.72.12/32
72.167.39.12/32
173.212.243.200/32
41.191.237.68/32
185.132.39.154/32
77.68.114.57/32
127.0.0.1/32
77.68.35.200/32
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
