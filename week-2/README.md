# Week 2

Unix command line

## Week Overview

This week we will talk about the Unix operating system. So that we all are using the same environment we will use a Docker Image for the book [Data Science at the Command Line](https://www.datascienceatthecommandline.com/index.html) by Jeroen Janssens. 

First we need to pull the image using the follwing:

docker pull datascienceworkshops/data-science-at-the-command-line

Then to run the image

docker run --rm -it datascienceworkshops/data-science-at-the-command-line

To leave the environment simply type `exit`

Now to mount your local directory as a volume using the following commands

Mac
docker run --rm -it -v`pwd`:/data datascienceworkshops/data-science-at-the-command-line

Windows command line
docker run --rm -it -v %cd%:/data datascienceworkshops/data-science-at-the-command-line

Windows powershell
docker run --rm -it -v ${PWD}:/data datascienceworkshops/data-science-at-the-command-line
  
## Resources

This Docker Image for the Unix environment we will use as a class came from this great book

[Data Science at the Command Line](https://www.datascienceatthecommandline.com/index.html) by Jeroen Janssens.

We won't be using all the resources from this book nor going through all the chapters but I suggest doing so outside of this course. They are valuable tools
