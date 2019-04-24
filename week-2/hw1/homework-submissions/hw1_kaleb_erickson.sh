#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l


# Question 1
echo " "
echo "Question 1: Top 10 web sites from which requests came."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | awk '{print $11}' | sort | uniq -c | sort -rn | head -n 15
echo " "


# Question 2
echo "Question 2: Top 10 local web pages requested."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | awk '{print $7}' | sort | uniq -c | sort -rn | head -n 10
echo " "

# Question 3
echo "Question 3: The top 10 web browsers and % of total."
echo " "
n=($(curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l))
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $21}' | sort | uniq -c | sort -rn | head -n 10 | awk -v n=$n '{print $2 " which was seen "  $1 " times and which makes up " $1/n*100 "% of total"}'
echo " "


# Question 4
echo "Question 4: List the number of 404 errors."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $9}' | grep "404" | wc -l
echo " "

# Question 5 
echo "Question 5: List the number of 500 errors."
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $9}' | grep "500" | wc -l
echo " "

# Question 6
echo "Question 6: What time of day is the site active? When is it quiet?"
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $4}' | cut -c 14-15 | sort | uniq -c | awk -v n=$n '{print "Hour "$2 " sees " $1/n*100 "% of total daily traffic"}'
# So the busiest hours appear to be between 12 - 4 pm and the quietest hours are between 4 - 5 am."
echo " "


# Question 7
echo "Question 7: Is the traffic 'real' or mostly robots and automated processes?"
echo " "
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $1}' | sort | uniq -c | sort -rn | head -n 10 | awk -v n=$n '{print $2 " had " $1 " requests in this time, which makes up " $1/n*100 "% of total requests."}'
# It's unlikely that human visitors would make so many requests in just a month-long period, indicating that the majority of this traffic is from robots or automated processes.
# Also, as seen in question 3, the majority of requests lack a web browser listing, further indicating that much of this traffic is from bots.
