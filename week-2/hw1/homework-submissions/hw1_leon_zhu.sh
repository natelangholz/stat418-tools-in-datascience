#!/bin/bash

# 1)
echo "Question 1"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v " 404 " | cut -d" " -f11 | sort | uniq -c | sort -r | head -n 10
# 28332 "-"
# 10133 "http://users.csc.tntech.edu/~mjkosa/"
# 3609
# 3544 "http://users.csc.tntech.edu/~mjkosa/2011s07/CSC%202011%20Lab%20Syllabus.htm"
# 2882 "http://users.csc.tntech.edu/~srini/DM/chapters/review4.3.html"
# 2799 "http://users.csc.tntech.edu/~CSJamalpur21/"
# 2728 "http://users.csc.tntech.edu/~srini/DM/chapters/review3.4.html"
# 2556 "http://users.csc.tntech.edu/~srini/DM/chapters/review2.4.html"
# 2482 "http://users.csc.tntech.edu/~sjcrook/westciv/default.css"
# 1723 "http://users.csc.tntech.edu/~jley/"
echo " "

# 2)
echo "Question 2"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v " 404 " | cut -d" " -f7 | sort | uniq -c | sort -r | head -n 10
# 1724 /~mjkosa/
# 1399 /~mjkosa/MarthaLeeds.jpg
# 1395 /~mjkosa/computerscience.jpg
# 1388 /~mjkosa/wvonline.jpg
# 1387 /~mjkosa/magyar.gif
# 1376 /~mjkosa/miniscruffy.jpg
# 1376 /~mjkosa
# 1350 /~mjkosa/2011s07/CSC%202011%20Lab%20Syllabus.htm
# 1324 /~mjkosa/2011s07/CSC%202011%20Lab%20Syllabus_files/mystyle.css
# 1308 /~mjkosa/miniwhitey.jpg
echo " "

# 3)
echo "Question 3"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v " 404 " | cut -d" " -f12 | sort | uniq -c | sort -r | head -n 10
# 52942 "Mozilla/5.0
# 46291 "Mozilla/4.0
# 5078 "sogou
# 3609
# 900 "msnbot-media/1.0
# 775 "msnbot/1.0
# 738 "Microsoft-WebDAV-MiniRedir/5.1.2600"
# 555 "Feedfetcher-Google;
# 512 "AppleSyndication/54"
# 468 "Opera/9.10
echo " "

# 4)
echo "Question 4"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep " 404 " | wc -l
# 19099
echo " "

# 5)
echo "Question 5"
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep " 500 " | wc -l
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