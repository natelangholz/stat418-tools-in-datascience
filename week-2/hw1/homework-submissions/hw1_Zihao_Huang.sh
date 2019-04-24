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
n=($(curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 12- | grep '^$' -v | wc -l))
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 12- | grep '^$' -v | sort | uniq -c | sort -nr | head -n 10 | awk -v n=$n '{print $1/n*100 "% " $0}'
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
echo "The site is mostly active during 15:00-16:00, and it is active during 9:00 - 22:00."
echo "The site is most quiet during 5:00-6:00, and it is quiet during 0:00 - 8:00."
echo " "


# 7. Is the traffic "real" or mostly the result of robots or automated processes?
echo '7. Is the traffic "real" or mostly the result of robots or automated processes?'
echo
echo "Requests made by robots or automated processes usually include certain words like 'spider', 'bot', 'crawler', 'fetcher' in their agent names."
# Real:
r=($(curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 12- | grep -iv -e spider -e bot -e crawler -e fetcher | wc -l))
# Bots:
b=($(curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d ' ' -f 12- | grep -i -e spider -e bot -e crawler -e fetcher | wc -l))
echo $((100*$r/$n))% of the traffic is real.
echo $((100*$b/$n))% of the traffic is the result of robots or automated processes.
echo
echo