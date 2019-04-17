# Homework 1

Parse the web server access log from the file located at http://users.csc.tntech.edu/~elbrown/access_log.bz2. You may complete this assignment with one script (.sh) or a shell script using a combination of Awk/cut scripts. Process the file by reading directly from the url (don't save to disk) above using bash commands. See the starter script in the submission folder.

Due date is Tuesday April 23, 2019 at 6pm. Please submit your script to the course github repo as a pull request to the homework submission folder here.

Answer the following questions with your script and have any words to support your commands written as comments.

1. List the top 10 web sites from which requests came (non-404 status, external addresses looking in).
2. List the top 10 local web pages requested (non-404 status).
3. List the top 10 web browsers used to access the site. It is not necessary to get fancy and parse out all of the browser string. Simply print out the information that is there. Display the percentage of all browser types that each line represents.
4. List the number of 404 errors that were reported in the log. 
5. List the number of 500 errors that were reported in the log. 

Advanced questions:

6. What time of day is the site active? When is it quiet?
7. Is the traffic "real" or mostly the result of robots or automated processes?

