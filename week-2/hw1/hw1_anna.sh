#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | head -10
# Question 1
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | cut -d " " -f11 | sort | uniq -c | sort -nr | head -12
echo "Chose head -12 because of the - and _(empty) elements getting captured."
# Question 2
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | cut -d " " -f7 | sort | uniq -c | sort -nr | head -10
# Question 3
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f12 | sort | uniq -c | sort -nr | awk '{print $2 " is seen " $1/234794 * 100 " % of the time"}' | head -10
echo "Got 234794 from the code in the HW1 starter file."
# Question 4
 curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep "404" | wc -l
# Question 5
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f9 | grep "500" | wc -l
# Question 6
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f4 | cut -c 14-15 | sort | uniq -c
echo "The busiest time frame appears to be from 12 pm to 4 pm, while the quietest time frame appears to be from 3 am to 7 am."
# Question 7
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d " " -f1 | sort | uniq -c | sort -ru | head -50
echo "I wish I knew how to be more creative and print the number of IP's that appeared more than 100 (or whatever threshold) times. But looking at the top 50 IP's that appeared the most, it appears that there does seem to be a strong presence of robot users."
