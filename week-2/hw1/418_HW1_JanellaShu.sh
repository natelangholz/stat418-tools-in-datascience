#!/bin/sh

#  418_HW.sh
#  
#
#  Created by Janella Shu on 4/20/19.
#  
#1
echo Top 10 website which requests came from
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 1,9,11 | cut -d ' ' -f 2,3 | grep -v '^404'| grep -i -E '[0-9][0-9][0-9] .*"http://' | cut -d '"' -f 2 | cut -d '/' -f 3 | grep -v -E 'csc.tntech.edu|[0-9]*\.[0-9]*\.[0-9]*\.[0-9]' | sort | uniq -c | sort -nr | head -n 10 | awk '{print $2}'
echo

#2
echo Top 10 local web pages
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 6,7,9 | grep -i '"get'| grep -v '404$' | cut -d ' ' -f 2 | awk '/[\/]$/ {print substr($0, 1, length($0)-1);next}; {print $0}' | grep -v -E -i '\.[a,b,c,d,e,f,g,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9][a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9]*' | awk '$1 !=""' | sort | uniq -c | sort -nr | head -n 10 | awk '{print $2}'
echo

#3
echo Top 10 web browsers used and percentage
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d '"' -f 6 | grep -v 'http://' | grep -v 'bot' | grep -v 'Google Desktop' | grep '[0-9]\.[0-9] ([a-z]' | sort | uniq -c | sort -nr | awk '{$30=FNR;A[$30,$0]=$1;I[$30];J[$0];sum=sum+$1} END{ for(i in I)for(j in J)printf "%8.6f%% %s \n",(A[i,j]/sum)*100,j}' | sort -nr | grep -v '0.000000\%' | rev | cut -d ' ' -f 3- | rev | cut -d ' ' -f 1,3- | head -n 10
echo

#4
echo Number of 404 errors
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 9 | grep '^404' | wc -l
echo

#5
echo Number of 500 errors
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 9 | grep '^500' | wc -l
