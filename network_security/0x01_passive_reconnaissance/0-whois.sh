#!/bin/bash
whois $1 | awk -F': ' 'BEGIN{split("Name Organization Street City State/Province Postal Code Country Phone Phone Ext Fax Fax Ext Email",f); for(i in f) for(j in c="Registrant Admin Tech") k[c[j] f[i]]=1} $1 in k{v=$2; sub(/^ */,"",v); if($1 ~ /Street/) v=v" "; s=$1; gsub(" ", "$", s); if($1 ~ /Ext$/ && v=="") v=""; print s "," v}' > "$1.csv"
