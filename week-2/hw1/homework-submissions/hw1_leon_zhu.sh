#!/bin/bash

# 1)
echo "Question 1"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 != 404' | awk '{print $11}' | sort | uniq -c | sort -r | head -n 10
echo " "

# 2)
echo "Question 2"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 != 404' | awk '{print $7}' | sort | uniq -c | sort -r | head -n 10
echo " "

# 3)
echo "Question 3"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $12}' | sort | uniq -c | sort -r | awk '{print $1/227574, $0}' |head -n 10
echo " "

# 4)
echo "Question 4"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 == 404' | wc -l
# 19099
echo " "

# 5)
echo "Question 5"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 == 500' | wc -l
echo " "
# 66

#6)
echo "Question 6"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d" " -f4 | cut -c 14-15 | sort | uniq -c | sort -r | head -n 1
echo "The busy hour is 15 or 3pm."
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d" " -f4 | cut -c 14-15 | sort | uniq -c | sort | head -n 1
echo "The quite hour is 5 or 5am."
echo " "

#7)
echo "Question 7"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v " 404 " | cut -d" " -f11 | sort | uniq -c | sort -r | head -n 10
echo "Using the results from question 1, we see that the most request was from "-" which does not appear to be a human
address. This could mean these requests are the result of robots."
echo " "