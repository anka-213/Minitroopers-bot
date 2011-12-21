#!/bin/bash

headfun() {
 gawk 'NR==1' 

}

friend=${2:-"kude2"}
pass="banka213"

list=${1:-$(cat minitroopers.txt)}
#list=${1:-$(. std_troopers.sh)}

for trooper in $list
do

   echo -e "\nUsing trooper $trooper"
   
   ## Get code
   
   rm cookie.txt
   code=$(wget --cookies=on --keep-session-cookies --save-cookies=cookie.txt "http://$trooper.minitroopers.com/login?login=$trooper&pass=$pass" -qO-|sed -n 's/.*?chk=\([^"]*\).*/\1/p'| headfun )

   [ -z $code ] && echo "Trying harder" && code=$(wget --cookies=on --keep-session-cookies --load-cookies=cookie.txt "http://$trooper.minitroopers.com/b/opp" -qO-|sed -n 's/.*;chk=\([^"]*\).*/\1/p'| headfun )

   echo "Code: \"$code\"" 

   while wget --cookies=on --load-cookies=cookie.txt --keep-session-cookies  "http://$trooper.minitroopers.com/hq" -qO- |grep -q "/b/raid"
   do
         echo -n "Raid: 4 means victory empty means error or defeat: "
      
      result=$(wget --cookies=on --load-cookies=cookie.txt --keep-session-cookies  "http://$trooper.minitroopers.com/b/raid?chk=$code" -qO-| sed -n 's/.*\/hq?money=\(.\).*/\1/p')
      echo "\"$result\""

   done
   ##
   for i in 1 2 3
   do
      echo "Attack number $i"
      
      echo -n "Assult: 2 means victory, 1 means defeat, empty means error: "
      
      result=$(wget --cookies=on --load-cookies=cookie.txt --keep-session-cookies  "http://$trooper.minitroopers.com/b/battle?friend=$friend;chk=$code" -qO-| sed -n 's/.*\/hq?money=\(.\).*/\1/p')
      echo "\"$result\""
      
      # Unlock missions
      wget --cookies=on --load-cookies=cookie.txt --keep-session-cookies  "http://$trooper.minitroopers.com/unlock?mode=miss;chk=$code" -qO- >/dev/null

      echo -n "Mission: 4 means victory empty means error or defeat: "
      
      result=$(wget --cookies=on --load-cookies=cookie.txt --keep-session-cookies  "http://$trooper.minitroopers.com/b/mission?chk=$code" -qO-| sed -n 's/.*\/hq?money=\(.\).*/\1/p')
      echo "\"$result\""
      
      echo
      
   done

done
