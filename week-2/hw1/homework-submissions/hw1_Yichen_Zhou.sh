#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l

# Question 1
echo " "
echo "Question 1: Top 10 web sites from which requests came."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | awk '{print $11}' | grep / | grep -v "-" | sort | uniq -c | sort -rn | head -n 10
echo " "

# Question 2
echo " "
echo "Question 2: Top 10 local web pages requested."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | awk '{print $7}' | sort | uniq -c | sort -rn | head -n 10
echo " "

# Question 3
echo " "
echo "Question 3: The top 10 web browsers and % of total."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | sort | grep / | uniq -c | sort -rn | head -n 10 | awk '{print $1/227574 OFS $0}'
echo " "

# Question 4
echo " "
echo "Question 4: List the number of 404 errors."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep "404" | wc -l
echo " "

# Question 5
echo " "
echo "Question 5: List the number of 500 errors."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep "500" | wc -l
echo " "

# Question 6
echo " "
echo "Question 6: What time of day is the site active? When is it quiet?"
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f4 | cut -c 14-15 | sort | uniq -c | sort -n
echo "The site is most active between 12:00 - 16:00"
echo "The site is most quiet between 3:00 - 7:00"
echo " "

# Question 7
echo " "
echo "Question 7: Is the traffic 'real' or mostly robots and automated processes?"
echo "Define bots: searching for words including i.e. 'google', 'bot', 'spider', 'crawl', 'msn', 'yahoo'"
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | grep -i -e "google" -e "bot" -e "spider" -e "crawl" -e "msn" -e "yahoo" | wc -l | awk '{print $1/234794}'
echo "Among all 234794 requests, at least about 16.8237% are the result of robots or automated processes. Therefore, we can judge most of the requests are 'real'. "
echo " "

