#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!
echo The total number of lines is
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l

#1. List the top 10 web sites from which requests came (non-404 status, external addresses looking in)

echo 1. List the top 10 web sites from which requests came
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 != 404' | awk '{print $11}' | sort | uniq -c | sort -rn | head -n 10

#2. List the top 10 local web pages requested (non-404 status)

echo 2. List the top 10 local web pages requested
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 != 404' | awk '{print $7}' | sort | uniq -c | sort -rn | head -n 10

#3. List the top 10 web browsers used to access the site. It is not necessary to get fancy and parse out all of the browser string. Simply print out the information that is there. Display the percentage of all browser types that each line represents.

echo 3. List the top 10 web browsers used to access the site
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $12}' | sort | uniq -c | sort -rn | awk -vn=234794 '{print $1, $1/n*100, $2}' | head

#4. List the number of 404 errors that were reported in the log.

echo 4. List the number of 404 errors that were reported in the log
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 == 404' | wc -l

#5. List the number of 500 errors that were reported in the log.

echo 5. List the number of 500 errors that were reported in the log
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '$9 == 500'| wc -l

#6. What time of day is the site active? When is it quiet?

echo 6. What time of day is the site active? When is it quiet?

echo 6-1. Top 10 busiest hours
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $4}' | cut -c 14-15 | sort | uniq -c | sort -rn | head -n 10

echo 6-2. Top 10 slowest hours
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $4}' | cut -c 14-15 | sort | uniq -c | sort | head -n 10

echo Answer: the site is generally active from noon to 5 PM and quiet from 3 AM to 7 AM.

#7. Is the traffic "real" or mostly the result of robots or automated processes?

echo 7. Is the traffic "real" or mostly the result of robots or automated processes?
echo Found out that the requests made by robots or automatic processes include certain words in their agent descriptions such as "Googlebot", "AskJeeves", "Digger", "Lycos", "msnbot", "Inktomi Slurp", "Yahoo", "Nutch", "bingbot", "BingPreview", "Mediapartners-Google", "proximic", "AhrefsBot", "AdsBot-Google", "Ezooms", "AddThis.com", "facebookexternalhit", "MetaURI", "Feedfetcher-Google", "PaperLiBot", "TweetmemeBot", "Sogou web spider", "GoogleProducer", "RockmeltEmbedder", "ShareThisFetcher", "YandexBot", "rogerbot-crawler", "ShowyouBot", "Baiduspider", "Sosospider" or "Exabot". So I tried to filter out the requests having the above words in their agent names.
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $12, $13, $14, $15, $16, $17, $18, $19, $20, $21}' | grep -E "Googlebot|AskJeeves|Digger|Lycos|msnbot|Inktomi Slurp|Yahoo|Nutch|bingbot|BingPreview|Mediapartners-Google|proximic|AhrefsBot|AdsBot-Google|Ezooms|AddThis.com|facebookexternalhit|MetaURI|Feedfetcher-Google|PaperLiBot|TweetmemeBot|Sogou web spider|GoogleProducer|RockmeltEmbedder|ShareThisFetcher|YandexBot|rogerbot-crawler|ShowyouBot|Baiduspider|Sosospider|Exabot" | sort | uniq -c | sort -rn | awk -vn=234794 '{print $1, $1/n*100, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11}' | head -n 20

echo The total number of requests is
curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | awk '{print $12, $13, $14, $15, $16, $17, $18, $19, $20, $21}' | grep -E "Googlebot|AskJeeves|Digger|Lycos|msnbot|Inktomi Slurp|Yahoo|Nutch|bingbot|BingPreview|Mediapartners-Google|proximic|AhrefsBot|AdsBot-Google|Ezooms|AddThis.com|facebookexternalhit|MetaURI|Feedfetcher-Google|PaperLiBot|TweetmemeBot|Sogou web spider|GoogleProducer|RockmeltEmbedder|ShareThisFetcher|YandexBot|rogerbot-crawler|ShowyouBot|Baiduspider|Sosospider|Exabot" | wc -l

echo Answer: We can see from the list that the top 5 of these requests account ~8%. The total number of requests including the above names in their agent description is 19792, which is equal to 8.09%, indiating that most of the traffic is real.
