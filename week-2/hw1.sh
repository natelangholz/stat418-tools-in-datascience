# Huilin Tang
# 4/23/2019
# STATS418-HW1

#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!

# curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc

## 1. List the top 10 web sites from which requests came (non-404 status, external addresses looking in).
##  curl: goes to the specified url to download the zip file
##  -s: fetches the file
##  grep: the most basic usage of the grep command is to search for a string (text) in a file
##  -v: To display the lines that do not match a pattern
##  bunzip2 -: will unzip
##  uniq: report or filter out repeated lines in a file
##  -c: conut

#  look at the pages that are doing the requesting
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | cut -d" " -f11 | sort | uniq -c | sort -r | head -n 10


## 2. List the top 10 local web pages requested (non-404 status).

# look at the pages that are being requested
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | cut -d" " -f7 | sort | uniq -c | sort -r | head -n 10


## 3. List the top 10 web browsers used to access the site. It is not necessary to get fancy and parse out all of the browser string. Simply print out the information that is there. Display the percentage of atll browser types that each line represents.

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d" " -f21 | sort | uniq -c | sort -r | head -n 20

## 4. List the number of 404 errors that were reported in the log.
## wc -l : Prints the number of lines in a file

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep "404" | wc -l


## 5. List the number of 500 errors that were reported in the log.

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep "500" | wc -l


## Advanced questions:
# 6. What time of day is the site active? When is it quiet?
# I first fetch the visit time by hour and count the number of visit in each hour and sort them.
# The result is that 3:00pm-4:00pm is the most active time period, and the most quiet time period 5:00am-6:00am.

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d":" -f2 | sort | uniq -c | sort -nr

# 7. Is the traffic "real" or mostly the result of robots or automated processes?
# For Feb in 2007, the most traffic time is 15:00-16:00. There is no abnormal behavior if we look at the IP visit within the month.
# Nevertheless, it still exist few abnormal phenonenon, such as on 07/Feb/2007 at 3:00pm-4:00pm, the IP address "24.159.27.178" requests more than 1000 times in an hour, which is most likely to be the result of robots or automated process.

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d":" -f1,2 | grep ":15" | tr ":" " " | cut -d" " -f1,5 | sort | uniq -c | sort -nr | head -n 10


curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d":" -f1,2 | grep ":15" | sort | uniq -c | sort -nr | head -n 10
