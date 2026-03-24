#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure
set firewall ipv4 name WAN-to-DMZ default-action 'drop'
set firewall ipv4 name WAN-to-DMZ rule 10 action 'accept'
set firewall ipv4 name WAN-to-DMZ rule 10 protocol 'tcp'
set firewall ipv4 name WAN-to-DMZ rule 10 destination port '22'
set firewall ipv4 name WAN-to-DMZ rule 10 destination address '172.16.50.4'
set firewall ipv4 name WAN-to-DMZ rule 10 description 'Allow WAN SSH to jump via DNAT'
set firewall zone DMZ from WAN firewall name 'WAN-to-DMZ'
commit
save
exit
