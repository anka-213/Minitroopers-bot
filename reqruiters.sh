for trooper in `cat minitroopers.txt`
do
   echo -n "$trooper was recruited by "
   wget "http://$trooper.minitroopers.com/ranks" -qO-|sed -n 's/.*blank">\([^<]*\)<.*/\1/p'|gawk 'NR==1'
done
