#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l

# Question 1

echo "Question 1: List the top 10 web sites from which requests came."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 != 404 {print}' | cut -d " " -f11 | grep . | grep -v "-" | sort | uniq -c | sort -rn | head -n 10
echo " "


# Question 2

echo "Question 2: List the top 10 local web pages requested."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 != 404 {print}' | cut -d " " -f7 | sort | uniq -c | sort -rn | head -n 10
echo " "


# Question 3

echo "Question 3: List the top 10 web browsers used to access the site. Display the percentage of all browser types that each line represents."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | grep . | sort | wc -l
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | grep . | sort | uniq -c | sort -rn | head -n 10 | awk '{print $1/227574 $0}'
echo " "


# Question 4

echo "Question 4: List the number of 404 errors that were reported in the log."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep "404" | wc -l
echo " "


# Question 5

echo "Question 5: List the number of 500 errors that were reported in the log."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep "500" | wc -l
echo " "


# Question 6

echo "Question 6: What time of day is the site active? When is it quiet?"
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f4 | cut -c 14-15 | sort | uniq -c
echo " "
echo "The site is usually active from 12:00 to 16:00 and quiet from 4:00 to 7:00."
echo " "


# Question 7

echo "Question 7: Is the traffic 'real' or mostly the result of robots or automated processes?"
echo " "
echo "Requests made by robots or automated processes usually include certain words like 'bot', 'spider', 'crawler', 'google', 'yahoo', etc. in their agent names."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -f12- -d " " | grep -i -E "bot|spider|crawler|google|yahoo" | wc -l | awk '{print $1/234794*100}' 
echo " "
echo "Among all 234794 requests, at least about 16.6951% were the result of robots or automated processes. Thus, most of the requests are 'real'. "
echo " "
