### R script for plotting house energy data
## Preconditions

# csv structure
# category, data, time, 

## Include R libraries
library(lattice)
library(ggplot2)
library(lubridate)
library(dplyr)
library(scales)
library(plyr)
library(readr)

## Create plot ready data frames

## Source data
# logfile <- read.csv(file.choose())
# logfile <- data.frame(logfile, fix.empty.names = TRUE, stringsAsFactors = TRUE) # build the logfile df
# str(logfile) # check it was read and the df has data

## Read in multiple csv files to a single data table
setwd("/home/leftbrainstuff/gitlocalrepo/R-stuff/deepracer/")
filedir = "logfiles/ifal-kuei-clone-5a"
logfiles = list.files(path=filedir, pattern="*.csv", full.names=TRUE)
str(logfiles)
head(logfiles)

# Read in multiple files in a single directory
cumlogfile = ldply(logfiles, read.csv, stringsAsFactors = FALSE)
str(cumlogfile)
head(cumlogfile)

## The plot
p <- ggplot(cumlogfile, aes(x=episode, y=reward)) +
  geom_point(aes(size=throttle, color=progress)) +
  coord_cartesian() +
  #scale_x_continuous(limits=c(0,max(countrydata$population_growth))) +
  #scale_y_continuous(limits=c(0,max(countrydata$birth_rate))) +
  #facet_wrap(~ action) +
  ggtitle("DeepRacer Log Data", subtitle = "ifal-kuei-clone-1")
p

## Save plot as image
# ggsave("DeepRacer Log Data.png", device = NULL, dpi = 300)
