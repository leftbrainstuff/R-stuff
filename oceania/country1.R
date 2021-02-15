### R script for plotting lattice plots of Oceanic countries
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
# year,education,health,telco,energy,natsec,environment

## Include R libraries
library(lattice)
library(ggplot2)
library(lubridate)
library(dplyr)
library(scales)

## Create plot ready data frames

## Source data
countrydata <- read.csv("/Users/ifal/Documents/gitlocalrepo/R-stuff/oceania/factbook-oceania2.csv")
# countrydata <- read.csv(file.choose()) # grab the polar data with columns TWA, TWS, VMG not SOG and sailplan(jib, main, staysail, spinaker) as % in seperate columns, Date (date) and Vessel Configuration (text) by date
countrydata <- data.frame(countrydata, fix.empty.names = TRUE, stringsAsFactors = TRUE) # build the countrydata df
str(countrydata) # check it was read and the df has data

## The plot
# p <- ggplot(countrydata, aes(x=year, y=education, color=year)) +
p <- ggplot(countrydata, aes(x=population_growth, y=birth_rate)) +
  geom_point() +
  geom_point(aes(size=migration_rate)) +
  coord_cartesian() +
  scale_x_continuous(limits=c(0,max(countrydata$population_growth))) +
  scale_y_continuous(limits=c(0,max(countrydata$birth_rate))) +
  facet_wrap(~ name) +
  ggtitle("Oceania Data", subtitle = "from CIA Factbook 2018")
p

## Save plot as image
# ggsave("oceania-countrydata.png", device = NULL, dpi = 300)
