### R script for plotting DeepRacer logs
## Preconditions
# place <countryname>.csv in the same directory as this script. Change <directory-path> to whatever works on your machine.
# Plot a 2row x 3 column plot of the following data by year
# Education (global ranking) as column
# Health (beds/1000pop) as column
# Telco (subscribers) as line chart
# Energy (capacity) as line chart
# NatSec (global ranking) as column chart
# Environment (xxx)

# csv structure
# episode, steps, X, Y, yaw, steer, throttle, action, reward, done, all_wheels_on_track, progress, closest_waypoint, track_len, tstamp, episode_status, pause_duration

## Include R libraries
library(lattice)
library(ggplot2)
library(lubridate)
library(dplyr)
library(scales)

## Create plot ready data frames

## Source data
# logfile <- read.csv(file.choose())
# logfile <- data.frame(logfile, fix.empty.names = TRUE, stringsAsFactors = TRUE) # build the logfile df
# str(logfile) # check it was read and the df has data

## Read in multiple csv files to a single data table
logfile <-
    list.files(pattern = "*.csv") %>% 
    map_df(~read_csv(.))
str(logfile)


## The plot
p <- ggplot(logfile, aes(x=episode, y=reward)) +
  geom_point() +
  geom_point(aes(size=throttle, color=progress)) +
  coord_cartesian() +
  #scale_x_continuous(limits=c(0,max(countrydata$population_growth))) +
  #scale_y_continuous(limits=c(0,max(countrydata$birth_rate))) +
  facet_wrap(~ action) +
  ggtitle("DeepRacer Log Data", subtitle = "ifal-kuei-clone-1")
p

## Save plot as image
# ggsave("DeepRacer Log Data.png", device = NULL, dpi = 300)
