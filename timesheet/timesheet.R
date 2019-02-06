### Visualization of timesheet data
## load libraries and configure R
#set the working directory
library(ggplot2)
library(lubridate) # handling date and time formats

## retrieve raw data
timesheet <- read.csv("<path to csv>")
timesheet <- data.frame(timesheet, fix.empty.names = TRUE,
           stringsAsFactors = TRUE)
str(timesheet)
timesheet <- data.frame(date=timesheet$Date, project=timesheet$Project, duration=as.character(timesheet$Duration))
names(timesheet)
head(timesheet)

## format duration for plotting
### add column to data frame
timesheet$durationminutes <- with(timesheet, (60 * 24))
### convert time to minutes from https://stackoverflow.com/questions/29067375/r-convert-hoursminutesseconds
library(chron) 
timesheet$durationminutes <- (60 * 24 * as.numeric(times(timesheet$duration)))

## plot data
g <- ggplot(data=timesheet, aes(reorder(project, durationminutes, sum), fill=project)) +
geom_bar(stat="identity", aes(y=durationminutes), show.legend=FALSE) +
theme(axis.title.x=element_blank(), axis.text.y=element_blank(), axis.text.x = 	   element_text(angle = 90, hjust = 1)) +
#scale_y_continuous("hours", durationminutes) +
ggtitle("Timesheet Summary for <person>") +
ylab("hours")
g

#Reorder x axis
aes(reorder(project, durationminutes, sum))


# save chart
ggsave("timesheet.png", device = NULL, dpi = 300)
