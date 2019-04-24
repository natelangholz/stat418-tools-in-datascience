## stat413_asawilks_hw1.sh
## homework 1
## ucla stats 413
## asa wilks 4.20.2019

##
# q1
##

# create file as list of sites from which requests came, excluding those with 404 status
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | cut -d" " -f11 > data

# get the top 12 unique - two of the top 10 appear to be missing
# (maybe i dont understand web logs)
sort data | uniq -c | sort -n -r | head -n

#  28309 "-"
#  10131 "http://users.csc.tntech.edu/~mjkosa/"
#   3608
#   3544 "http://users.csc.tntech.edu/~mjkosa/2011s07/CSC%202011%20Lab%20Syllabus.htm"
#   2882 "http://users.csc.tntech.edu/~srini/DM/chapters/review4.3.html"
#   2799 "http://users.csc.tntech.edu/~CSJamalpur21/"
#   2728 "http://users.csc.tntech.edu/~srini/DM/chapters/review3.4.html"
#   2556 "http://users.csc.tntech.edu/~srini/DM/chapters/review2.4.html"
#   2482 "http://users.csc.tntech.edu/~sjcrook/westciv/default.css"
#   1723 "http://users.csc.tntech.edu/~jley/"
#   1389 "http://users.csc.tntech.edu/~SDGoteti21/india'06/photos/"
#   1224 "http://users.csc.tntech.edu/~mjkosa/2011s07/"

##
# q2
##

# create file as list of sites requested, excluding those with 404 status
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | grep -v "404" | cut -d" " -f7 > data

# get top 11 requested
sort data | uniq -c | sort -n -r | head -n 10

#   1724 /~mjkosa/
#   1399 /~mjkosa/MarthaLeeds.jpg
#   1395 /~mjkosa/computerscience.jpg
#   1388 /~mjkosa/wvonline.jpg
#   1387 /~mjkosa/magyar.gif
#   1376 /~mjkosa/miniscruffy.jpg
#   1376 /~mjkosa
#   1350 /~mjkosa/2011s07/CSC%202011%20Lab%20Syllabus.htm
#   1324 /~mjkosa/2011s07/CSC%202011%20Lab%20Syllabus_files/mystyle.css
#   1308 /~mjkosa/miniwhitey.jpg

##
# q3
## 

# create file as list of browsers
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d" " -f12 > data

# print top 10, with counts
sort data | uniq -c | sort -r | head -n 10

# 102802 "Mozilla/5.0
#  91134 "Mozilla/4.0
#  16126 "sogou
#   7220
#   3731 "msnbot/1.0
#   2133 "msnbot-media/1.0
#   1904 "Microsoft-WebDAV-MiniRedir/5.1.2600"
#   1778 "ConveraCrawler/0.9e
#   1321 "Mozilla/2.0
#   1169 "AppleSyndication/54"

# print top 10 with percentages
awk '{a[$0]++} END{for (i in a) if (a[i]>1) printf "%5.2f%%\t%s\n", 100*a[i]/NR, i}' data | sort -r | head -n 10

#43.78%  "Mozilla/5.0
#38.81%  "Mozilla/4.0
# 6.87%  "sogou
# 3.08%
# 1.59%  "msnbot/1.0
# 0.91%  "msnbot-media/1.0
# 0.81%  "Microsoft-WebDAV-MiniRedir/5.1.2600"
# 0.76%  "ConveraCrawler/0.9e
# 0.56%  "Mozilla/2.0
# 0.50%  "AppleSyndication/54"
 
 
##
# q4
##

# get file of error status
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d" " -f9 > data

# limit to 404 and count
grep "404" data | uniq -c

#   34167 404

 ##
 # q5
 ##

# limit to 500 and count
grep "500" data | uniq -c
 
# 137 500
 
##
# q6
##

# Peak traffic is in the 3pm hour, with noon to 4pm being the busiest four hour preiod.
# The 5am hour is the least busy with 3am to 7am being the least busy four hour preiod.

# save timestamps only
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | cut -d" " -f4 > timestamps

# count hours
cut -d":" -f2 timestamps > hours
awk '{a[$0]++} END{for (i in a) if (a[i]>1) printf "%5.2f%%\t%s\n", 100*a[i]/NR, i}' hours | sort -r 

# 7.00%  15
# 6.31%  12
# 6.20%  13
# 5.41%  14
# 5.38%  16
# 5.28%  17
# 5.18%  19
# 5.15%  09
# 5.10%  10
# 5.07%  11
# 5.02%  20
# 5.00%  18
# 4.77%  21
# 4.33%  22
# 3.76%  23
# 3.76%  08
# 3.26%  02
# 2.85%  00
# 2.40%  01
# 2.20%  07
# 2.01%  03
# 1.61%  06
# 1.59%  04
# 1.35%  05


##
# q7
##

# look for obvious bots, not case sensitive
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - > data
grep -i -e bot -e slurp -e crawler data > bots

# Found 10102 of 234794 (just over four percent) as obvious bots.
# This is a small minority but there may be more that do not identify themselves.
wc -l bots
wc -l data

#10102 bots
#234794 data
