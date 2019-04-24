#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!
echo '... count of total entries ...'
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l


# 1. List the top 10 web sites from which requests came (non-404 status, external addresses looking in).
echo ' '
echo '... Q1: top 10 sites where requests come from ...'
echo ' ' 
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - |   # load data
grep -v ' 404 ' |	 														# exclude anything with "404" text
awk -F 'http://' '{ split($2,a,"/"); print a[1] }' | 					    # only include text between http:// and the next /
grep -v -e '^$' |															# exclude blank results
sort | uniq -c | sort -nr |													# group, count, and sort descending
head -10 																	# chose top 10
echo ' '


# 2. List the top 10 local web pages requested (non-404 status).
echo '... Q2: top 10 local web pages requested ...'	
echo ' ' 
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - |   # load data
grep -v ' 404 ' |															# exclude anything with "404" text
cut -d" " -f7 | cut -d"?" -f1 | 											# cut at space, choose the 7th field, then cut field before ?
sort | uniq -c | sort -nr |													# group, count, and sort descending
head -10																	# chose top 10				
echo ' '


# 3. List the top 10 web browsers used to access the site. It is not necessary to get fancy and parse out all of the browser string. 
# Simply print out the information that is there. Display the percentage of all browser types that each line represents.
echo '... Q3: top 10 browsers ...'
echo ' ' 
ct=($(curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | 
	bunzip2 - | wc -l))														# variable for total number of requests
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - |   # load data
rev | cut -d "/" -f2  | rev |												# reverse text, cut at /, chose 2nd field, reverse back
rev | cut -d ' ' -f1 | rev |                                                # reverse text, cut at space, chose 1st field, reverse back
sort | uniq -c | sort -nr |													# group, count, and sort descending
head -10 |																	# chose top 10
awk -v ct=$ct '{print $2 " ..... "  $1 " times ..... " $1/ct*100 "% of total"}'
echo ' '


# 4. List the number of 500 errors that were reported in the log. 
echo '... Q4: number of 404 errors is ...'
echo ' ' 
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - |   # load data
grep ' 404 ' |																# select lines with "404" text
wc -l 																		# count number of the lines
echo ' '


# 5. List the number of 500 errors that were reported in the log. 
echo '... Q5: number of 500 errors is ...'
echo ' ' 
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - |   # load data
grep ' 500 ' |																# select lines with "500" text
wc -l 																		# count number of lines
echo ' '


# Advanced questions:

# 6. What time of day is the site active? When is it quiet?
echo '... Q6: time of day where site is most/least active ...'
echo ' ' 
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - |   # load data
cut -d " " -f4 |															# isolate timestamp from request
cut -c 14-15 |																# isolate hour in the timestamp
sort | uniq -c | sort -nr          											# group, count, and sort descending
echo 'Highest traffic appears to be between 12pm - 3pm'
echo 'Lowest traffic appears to be between 3am - 6am'
echo  ' '


# 7. Is the traffic "real" or mostly the result of robots or automated processes?
echo '... Q7: is the traffic "real" or from bots? ...'
echo ' ' 
echo ' number of robots'
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - |    
	grep -i 'bot' |																
	wc -l 					  												    # number of lines with 'bot' (ignore case)
echo ' number of normal traffic'
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - |    
	grep -v -i 'bot' |																
	wc -l 					  												    # number of lines without 'bot'
echo ' '
echo 'robots .... 5.9% (13807/234794)'
echo 'real traffic .... 94.1%  (220987/234794)'
