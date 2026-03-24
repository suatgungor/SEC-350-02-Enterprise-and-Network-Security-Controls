#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure
set firewall ipv4 name DMZ-to-LAN default-action 'drop'
set firewall ipv4 name DMZ-to-LAN default-log
set firewall ipv4 name DMZ-to-LAN rule 1 action 'accept'
set firewall ipv4 name DMZ-to-LAN rule 1 state 'established'
set firewall ipv4 name DMZ-to-LAN rule 1 state 'related'
set firewall ipv4 name DMZ-to-LAN rule 20 action 'accept'
set firewall ipv4 name DMZ-to-LAN rule 20 protocol 'tcp'
set firewall ipv4 name DMZ-to-LAN rule 20 destination port '1514-1515'
set firewall zone LAN from DMZ firewall name 'DMZ-to-LAN'
commit
save
exit
