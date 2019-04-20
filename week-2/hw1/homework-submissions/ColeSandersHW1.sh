#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l

#Question 1 
#Pulls the top 10 ip-address from which request came
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '($9 !~ /404/)' | awk '{print $1}' | sort | uniq -c | sort -r | head -10

#Question 2
#Displays the top 10 request which indlude the local address requested
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '($9 !~ /404/)' | awk -F\" '{print $2}' | sort | uniq -c | sort -r | head -10

#Question 3
#Pulls the top 10 browsers based on percentage. Since we didn't do any clean up, per the instructions, this is a guess at best
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 | awk -F\" '{print $6}'  | sort | uniq -c | sort -r | head -10 | awk '{print $1 / 234794, $2}'

#Question 4
#Count the lines where the status code = 404
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '($9 ~ /404/)' | wc -l

#Question 5
#Count the lines where the status code = 500
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '($9 ~ /500/)' | wc -l

#Question 6
# Returns a list of military hours and the percentage of total request at each time. From this we can see that 5AM has the lowest precentage of Traffic at .6% and 3PM has the highest at 6.99%.
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '{print substr($4,14,2)}' | sort | uniq -c | awk '{print $1 / 234794, $2}' | sort

#Question 7
#We print out the end of the log where more detailed information about the tech browser the users is using is shown and look for common webscrapping tools.
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 |awk '{print $20}'| sort | uniq -c | sort -r
#Then we use a grep command looking for anything that has a key word found above.
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 | grep -E 'bot|Gecko|spider' | wc -l
#This produces the number of request that might have been automated. Further there are references to the CLI and .NET, technologies in the Microsoft stack that could be used for webscraping but also might be used in refrence to the website. If we indclude these we get the following.
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 | grep -E 'bot|Gecko|spider|NET|CLI' | wc -l


