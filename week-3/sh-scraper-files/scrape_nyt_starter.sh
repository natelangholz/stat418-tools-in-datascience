#!/bin/bash

# this pulls data from the NY Times developer api through the 'Data Science at the Command Line' book linux environment
#script adapted from 'Data Science at the Command Line' book

https://api.nytimes.com/svc/search/v2/articlesearch.json?q=Notre-Dame&begin_date=20140101&end_date=20191231&page=1&api-key=WfbCjPGhhQDTo919yIXJmxEoq33NNXul

#takes some time as there is a 7 second delay
parallel -j1 --progress --delay 7 --results results "curl -sL "\
"'http://api.nytimes.com/svc/search/v2/articlesearch.json?q=Notre+Dame+'"\
"'Cathedral&begin_date={1}0101&end_date={1}1231&page={2}&api-key='"\
"'<your-api-key-here>'" ::: {2016..2019} ::: {0..40} > /dev/null

cat results/1/*/2/*/stdout | head -n 5
#rm results/1/*/2/*/stdout

tree results | head

cat results/1/*/2/*/stdout |
jq -c '.response.docs[] | {date: .pub_date, type: .document_type, '\
'title: .headline.main }' | json2csv -p -k date,type,title > notre-dame-articles.csv


wc -l notre-dame-articles.csv

< notre-dame-articles.csv cols -c date cut -dT -f1 | head | csvlook



