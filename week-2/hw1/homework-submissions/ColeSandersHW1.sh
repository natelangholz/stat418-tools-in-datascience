#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!
#curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l

echo "Question 1" 
echo "Top 10 Websited request"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '($9 !~ /404/)' | awk '{print $11}' | sort | uniq -c | sort -rn | head -10

echo "Question 2"
echo "Displays the top 10 local addresses requested"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '($9 !~ /404/)' | awk -F\" '{print $2}' | sort | uniq -c | sort -rn | head -10

echo "Question 3"
echo "Pulls the top 10 browsers based on percentage. Since we didn't do any clean up, per the instructions, this is a guess at best. 234794 is the number of lines in the file."
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 | awk -F\" '{print $6}'  | sort | uniq -c | sort -rn | head -10 | awk '{print $1 / 234794, $2}'

echo "Question 4"
echo "Count the lines where the status code = 404"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '($9 ~ /404/)' | wc -l

echo "Question 5"
echo "Count the lines where the status code = 500"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '($9 ~ /500/)' | wc -l

echo "Question 6"
echo "Returns a list of military hours and the percentage of total request at each time. From this we can see that 5AM has the lowest precentage of Traffic at .6% and 3PM has the highest at 6.99%."
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '{print substr($4,14,2)}' | sort | uniq -c | awk '{print $1 / 234794, $2}' | sort

echo "Question 7"
echo "We print out the end of the log where more detailed information about the tech browser the users is using is shown and look for common webscrapping tools."
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '{print $20}'| sort | uniq -c | sort -r
echo "Then we use a grep command looking for anything that has a key word found above."
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 | grep -E 'bot|Gecko|spider' | wc -l | awk '{print $1 / 234794, $2}'
echo "This shows that about 30% of request showed suppicious behavior, and there are also likely other keywords we missed. However it seems likely a large chunch of these request are not being made by people."
