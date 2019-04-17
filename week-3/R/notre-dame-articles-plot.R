#at this point I wouldn't suggest running this unless you are running it locally with dplyr, ggplot2, and readr already installed. They take quite some time to install

#install.packages('pacman')
#pacman::p_load(dplyr,ggplot2,readr)
g <- read_csv("~/Documents/Egnyte/Private/nlangholz/UCLA/stat418-tools-in-datascience/week-3/sh-scraper-files/notre-articles.csv")
ggplot(g) + geom_freqpoly(aes(as.Date(date), color=type),binwidth=7) + scale_x_date() + labs(x="date", title="Notre Dame Cathedral Coverage in NY Times")
