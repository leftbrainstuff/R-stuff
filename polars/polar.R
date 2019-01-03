### R script for plotting yacht performance polars
## Preconditions
# place polars.csv in the same directory as this script. Change /Users/ifal/WorkDocs/RScratch/ to whatever works on your machine. Tested on a Mac running R 3.3.3 with the following libraries

## Include R libraries
library(ggplot2)
library(ggrepel)
library(lubridate)
library(dplyr)
library(scales)

## Create plot ready data frames

## Source data
polars <- read.csv("/Users/ifal/WorkDocs/RScratch/polars.csv") # grab the polar data with columns TWA, TWS, VMG not SOG and sailplan(jib, main, staysail, spinaker) as % in seperate columns, Date (date) and Vessel Configuration (text) by date
Polars <- data.frame(polars, fix.empty.names = TRUE, stringsAsFactors = TRUE) # build the polars df
str(polars) # check it was read and the df has data

## The plot
p <- ggplot(polars, aes(x=TWA, y=VMG, color=Date)) +
geom_point() +
geom_point(aes(size=TWS)) +
coord_polar() +
scale_x_continuous(limits=c(0,360), breaks=seq(0, 360, by=45), minor_breaks=seq(0, 360, by=15)) +
scale_y_continuous(limits=c(0,max(polars$VMG)), breaks=seq(0, 12, by=1)) +
ggtitle("Yacht Polars")
p
ggsave("yacht-polars.png", device = NULL, dpi = 300)
