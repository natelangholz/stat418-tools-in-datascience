#!/bin/bash

# Tanner Koscinski
# Stats 418
# Homework 1

# 1. List the top 10 web sites from which requests came (non-404 status, external addresses looking in).
echo
echo
echo '1. List the top 10 web sites from which requests came (non-404 status, external addresses looking in).'
echo
echo Count Address
#curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{if ($9 != 404) {print $11}}' | grep '^"-"$' -v | grep '^$' -v | sort | uniq -c | sort -nr | head -n 10
echo

# 2. List the top 10 local web pages requested (non-404 status).
echo '2. List the top 10 local web pages requested (non-404 status).'
echo
echo Count Page
#curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{if ($9 != 404) {print $7}}' | sort | uniq -c | sort -nr | head -n 10
echo

# 3. List the top 10 web browsers used to access the site. It is not necessary to get fancy and parse out all of the browser string. Simply print out the information that is there. Display the percentage of all browser types that each line represents.
echo '3. List the top 10 web browsers used to access the site. It is not necessary to get fancy and parse out all of the browser string. Simply print out the information that is there. Display the percentage of all browser types that each line represents.'
echo
echo Percent Count Browser
#n=($(curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 12- | grep '^$' -v | wc -l))
#curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 12- | grep '^$' -v | sort | uniq -c | sort -nr | head -n 10 | awk -v n=$n '{print $1/n*100 "% " $0}'
echo

# 4. List the number of 404 errors that were reported in the log.
echo '4. List the number of 404 errors that were reported in the log.'
echo
echo Count
#curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{if ($9 == 404) {print $9}}' | wc -l
echo

# 5. List the number of 500 errors that were reported in the log.
echo '5. List the number of 500 errors that were reported in the log.'
echo
echo Count
#curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{if ($9 == 500) {print $9}}' | wc -l
echo

# 6. What time of day is the site active? When is it quiet?
echo '6. What time of day is the site active? When is it quiet?'
echo
echo Count Hour
#curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ':' -f 2 | sort | uniq -c | sort -nr
echo
echo 'The site is most active during the hour 15:00-16:00 (3-4 PM CST). There is high activity from 12:00-18:00 (12-6 PM CST).'
echo 'The site is the most quiet during the hour 5:00-6:00 (5-6 AM CST). There is low activity from 3:00-8:00 (3-8 AM CST).'
echo

# 7. Is the traffic "real" or mostly the result of robots or automated processes?
echo '7. Is the traffic "real" or mostly the result of robots or automated processes?'
echo
