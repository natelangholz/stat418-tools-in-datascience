#!/bin/sh

#  418_HW.sh
#  
#
#  Created by Janella Shu on 4/20/19.
#  
#1 List the top 10 web sites from which requests came (non-404 status, external addresses looking in).
echo Top 10 website which requests came from
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 1,9,11 | cut -d ' ' -f 2,3 | grep -v '^404'| grep -i -E '[0-9][0-9][0-9] .*"http://' | cut -d '"' -f 2 | cut -d '/' -f 3 | grep -v -E 'csc.tntech.edu|[0-9]*\.[0-9]*\.[0-9]*\.[0-9]' | sort | uniq -c | sort -nr | head -n 10 | awk '{print $2}'
echo

#2 List the top 10 local web pages requested (non-404 status).
echo Top 10 local web pages
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 6,7,9 | grep -i '"get'| grep -v '404$' | cut -d ' ' -f 2 | awk '/[\/]$/ {print substr($0, 1, length($0)-1);next}; {print $0}' | grep -v -E -i '\.[a,b,c,d,e,f,g,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9][a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9]*' | awk '$1 !=""' | sort | uniq -c | sort -nr | head -n 10 | awk '{print $2}'
echo

#3 List the top 10 web browsers used to access the site.
echo Top 10 web browsers used and percentage
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d '"' -f 6 | grep -v 'http://' | grep -v 'bot' | grep -v 'Google Desktop' | grep '[0-9]\.[0-9] ([a-z]' | sort | uniq -c | sort -nr | awk 'BEGIN{I[$0]}{I[$0]=$1;sum=sum+$1} END{ for(i in I) printf "%8.6f%% %s \n",(I[i]/sum)*100,i}' | sort -nr | cut -d ' ' -f 1,3- | head -n 10
echo

#4 List the number of 404 errors that were reported in the log.
echo Number of 404 errors
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 9 | grep '^404' | wc -l
echo

#5 List the number of 500 errors that were reported in the log.
echo Number of 500 errors
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 9 | grep '^500' | wc -l
echo

#6 What time of day is the site active? When is it quiet?
echo Number of request and time of day, GMT
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 4,5 | cut -c 14-27 | awk -F ":" '{print $1,$2,$3}' | awk '{if(($1 - substr($4,3,1)) < 0) print $1 - substr($4,3,1)+24; else print $1 - substr($4,3,1)}'| sort | uniq -c | sort -nr
echo
#Seems to be active all hours during the day, ~50% of the site activity happens from between 5AM - 1PM (GMT).
#Top 5 least active hours are 9PM, 10PM, 11PM, 12AM, and 1AM.

#7 Is the traffic "real" or mostly the result of robots or automated processes?
echo Total number of requests where an IP address made multiple requests at the same time according to the access log
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $1,$4,$5}' | sort | uniq -c | sort -rn | awk '{if($1 > 1) print $1,$2,$3,$4}'| awk '{sum = sum + $1} END{print sum}'
echo

echo Total number of requests in the access log
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $1,$4,$5}' | sort | uniq -c | sort -rn | awk '{sum = sum + $1} END{print sum}'

#I assumed that requests made within the same second (i.e. having the same request time in the access log) are not part of “real” traffic.
#147455/234794 = ~ 63% of the traffic seems to be a result of robots or automated processes.
