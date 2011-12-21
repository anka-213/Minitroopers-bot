for trooper in `cat minitroopers.txt`; do firefox -new-tab "http://$trooper.minitroopers.com/t/0";read -t 30;done
