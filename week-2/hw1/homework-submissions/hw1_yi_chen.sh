#!/bin/bash



# Question 1
# NOTE: removing blanks and "-"
#-------------
echo "QUESTION 1: List top 10 sites from which requests came"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{ if($9 != 404) {print}}' | cut -d " " -f12 | grep . | grep -v "-" | sort | uniq -c | sort -nr | head -n 10
echo " "
echo " "


# Question 2
#-------------
echo "QUESTION 2: List top 10 local web pages requested"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{ if($9 != 404) {print}}' | cut -d " " -f7 | sort | uniq -c | sort -nr | head -n 10
echo " "
echo " "


# Question 3
#-------------
echo "QUESTION 3: Display top ten browsers and associated percentages"

n=($(curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f12| sort | wc -l))
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f12| sort | grep . | uniq -c | sort -nr | head -n 10 | awk -v n=$n '{print $1/n "percentages" }'
echo " "
echo " "



# Question 4
#-------------
echo "QUESTION 4: Number of 404 errors that were reported in the log"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep -ic 404
echo " "
echo " "


# Question 5
#-------------
echo "QUESTION 5: Number of 500 errors that were reported in the log"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep -ic 500
echo " "
echo " "
