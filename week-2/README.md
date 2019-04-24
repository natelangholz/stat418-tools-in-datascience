# Week 2

## Week Overview

Discuss docker a bit more with some additional implementation. Discuss some GitHub.

We will also talk about the Unix operating system. To introduce the shell means to have a discussion about the structure of the computer, operating systems, file systems and history. The shell offers programmatic access to a computer’s underlying parts, providing the ability to “do” data analysis on directories, on processes, and on their networks. 

So that we all are using the same environment we will use a Docker Image for the book [Data Science at the Command Line](https://www.datascienceatthecommandline.com/index.html) by Jeroen Janssens. 

First we need to pull the image using the follwing:

`docker pull datascienceworkshops/data-science-at-the-command-line`

Then to run the image

`docker run --rm -it datascienceworkshops/data-science-at-the-command-line`

To leave the environment simply type `exit`

Now to mount your local directory as a volume using the following commands

On a Mac:
`docker run --rm -it -v`pwd`:/data datascienceworkshops/data-science-at-the-command-line`

In Windows command line (hasn't worked)
`docker run --rm -it -v %cd%:/data datascienceworkshops/data-science-at-the-command-line`

In Windows powershell (hasn't worked)
`docker run --rm -it -v ${PWD}:/data datascienceworkshops/data-science-at-the-command-line`

Set up [Windows Docker with local directory](https://github.com/natelangholz/stat418-tools-in-datascience/blob/master/week-2/Setting%20up%20Docker%20to%20Work%20with%20Local%20Files%20on%20Windows.pdf). Thanks to Kaleb for setting this up!!

  
## Resources

[Slides](https://github.com/natelangholz/stat418-tools-in-datascience/blob/master/week-2/slides-week-2.pdf)


-----

Some Git resources

https://git-scm.com/book/en/v2

https://www.git-tower.com/blog/git-cheat-sheet

https://guides.github.com/introduction/git-handbook/

http://happygitwithr.com

------

This Docker Image for the Unix environment we will use as a class came from this great book

[Data Science at the Command Line](https://www.datascienceatthecommandline.com/index.html) by Jeroen Janssens.

We won't be using all the resources from this book nor going through all the chapters but I suggest doing so outside of this course. They are valuable tools that will only improve your productivity as a Data Scientist.


