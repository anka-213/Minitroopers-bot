#!/bin/bash

list=${1:-$(cat minitroopers.txt)}
for trooper in $list
do

money=$(wget --cookies=on --load-cookies=cookie.txt --keep-session-cookies  "http://$trooper.minitroopers.com/t/0" -qO-|grep -A1 "money" |grep -v "money")

cost=$(wget --cookies=on --load-cookies=cookie.txt --keep-session-cookies  "http://$trooper.minitroopers.com/t/0" -qO-|grep -A2 "Upgrade"|gawk 'NR==3')

# begin Recruited by
recruiter=$(wget "http://$trooper.minitroopers.com/ranks" -qO-|sed -n 's/.*blank">\([^<]*\)<.*/\1/p'|gawk 'NR==1')
# end Reqruited by

echo "$trooper($recruiter) has \"$money\" gold, need \"$cost\" gold"


if [[ "$money" -ge "$cost" ]] 
then
    echo "$trooper can afford an upgrade, press y to open browser" 
    read -n1 ans
    [[ "$ans" != n ]] && firefox -new-tab "http://$trooper.minitroopers.com/t/0"
fi

done
