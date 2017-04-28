#!/bin/bash
#generate a list of all firewall rules ONLY VALID FOR VSYS1 APPEND MORE VSYS if necessary!
panxapi.py -xsr "/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/security/rules"|grep "entry name" |cut -d'"' -f2 > firewall-rules.txt

firewallrules='firewall-rules.txt'

for i in $firewallrules;
  do 
    appid = panxapi.py -xsr "/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/security/rules/entry[@name='$i']"| sed -n 's:.*<.*>\(.*\)</.*>.*:\1:p' |sed -n 6p;
    if [[ $appid==any ]]; then  
     echo $i > no-appid.txt
    fi
done 
