#!/bin/bash

# Stat 418: Homework 1
# Chen, Joy


# Question 1
# NOTE: removing blanks and "-"
#-------------
echo "QUESTION 1: List top 10 sites from which requests came"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{ if($9 != 404) {print}}' | cut -d " " -f11 | grep . | grep -v "-" | sort | uniq -c | sort -nr | head -n 10
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
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | sort | grep . | uniq -c | sort -nr | head -n 10 | awk '{print $1/227574 OFS $0}'
echo " "
echo " "

# Total lines (including no-browser info): 234,794
# curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | sort | wc -l
# Total lines after removing empty no-browser info lines: 227,574
# curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | sort | grep . | wc -l


# Question 4
#-------------
echo "QUESTION 4: Number of 404 errors"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep -ic 404
echo " "
echo " "


# Question 5
#-------------
echo "QUESTION 5: Number of 500 errors"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep -ic 500
echo " "
echo " "


# Question 6
# -------------
echo "QUESTION 6: What time of day is site quiet vs. active?"
echo " "
echo "The site is most active between the hours of 12:00PM - 3:00PM"
echo "The site is most quiet between the hours of 03:00AM - 07:00AM"
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f4 | cut -c 14-15 | sort | uniq -c
echo " "
echo " "


# Question 7
# -------------
echo "QUESTION 7: Is traffic 'real' or from bots?"
echo "IDENTIFYING BOTS: searching for key-terms i.e. 'bot', 'crawl', etc."
echo "NOTE: does not include queries with no browser info"

echo " "
echo " "
echo "Query # from bots: "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | sort | grep -i -e "google" -e "bot" -e "spider" -e "crawl" -e "msn" -e "fetch" | wc -l
echo " "
echo "% of ALL Queries from bots: "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | sort | grep -i -e "google" -e "bot" -e "spider" -e "crawl" -e "msn" -e "fetch" | wc -l | awk '{print $1/234794}'
echo " "
echo "Bots identified: "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | sort | grep -i -e "google" -e "bot" -e "spider" -e "crawl" -e "msn" -e "fetch" | sort | uniq -c | sort -nr | wc -l
echo " "
echo " "
# REAL TRAFFIC
echo "% of ALL Queries from real traffic (i.e. inverse of bot queries): "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f 12- | sort | grep -iv -e "google" -e "bot" -e "spider" -e "crawl" -e "msn" -e "fetch" | wc -l | awk '{print $1/234794}'
echo " "
echo " "

# CONCLUSION
# MOST OF THE TRAFFIC (~86.8%) IS REAL, WHILE BOTS ACCOUNT FOR ~13.2% OF ALL QUERIES