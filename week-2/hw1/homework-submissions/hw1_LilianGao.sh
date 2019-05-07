#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l
# total 234794 lines

# Question 1
echo "Q1. List the top 10 web sites from which requests came excluding 404 status"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | cut -d" " -f11 | grep . | grep -v "-" | sort | uniq -c | sort -nr | head -n 10
echo " "


# Question 2
echo "Q2. List the top 10 local web pages requested excluding 404 status"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | cut -d" " -f7 | sort | uniq -c | sort -nr | head -n 10
echo " "


# Question 3
echo "Q3. List the top 10 web browsers used to access the site"
## There are 234,794 lines in the file
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 21 | grep . | sort | uniq -c | sort -nr | head -n 10 | awk '{ print 100*$1/234794"% of total using", $2 }'
echo " "


# Question 4
echo "Q4. List the number of 404 errors that were reported in the log"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 9 | grep "404" | wc -l
echo " "


# Question 5
echo "Q5. List the number of 500 errors that were reported in the log"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 9 | grep "500" | wc -l
echo " "


## Advanced questions:

# Question 6
echo "Q6. What time of day is the site active? When is it quiet?"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d":" -f2 | sort | uniq -c |sort -nr | head -n 5 | awk '{ print 100*$1/234794"% of total visits happens during", $2":00" }'
echo "most active time period: 12:00 - 16:00"
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d":" -f2 | sort | uniq -c |sort -nr | tail -n 5 | awk '{ print 100*$1/234794"% of total visits happens during", $2":00" }'
echo "most quiet time period: 03:00 - 07:00"
echo " "


# Question 7
echo "Q7. Is the traffic real or mostly the result of robots or automated processes?"

## count # visitor IPs that appear more than 100 times within the 1.5-month period (abnormal cases)
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d" " -f1 | sort | uniq -c | sort -nr | awk '{ if($1 > 100) {print}}' | wc -l
echo " "

## count # different visitor IPs in total
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d" " -f1 | sort | uniq -c | sort -nr | wc -l
echo " "

## Thus, 322 out of 8278 cases behave abnormally, which is only 4% of total. Hence, I would conclude that most of the traffic seem to be real.

