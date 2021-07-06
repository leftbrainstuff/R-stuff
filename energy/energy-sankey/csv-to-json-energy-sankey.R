# R Script to plot tabular energy data to Sankey plot

# Load libraries
library(plotly)
packageVersion('plotly') # check package version

# Import data from csv and convert to json lists
print(getwd()) # confirm data files are in local directory
#csvdata <- read.csv("energy.csv") # columns are date, source, target, value, units
f <- file.choose()
d <- read.csv(f)

# Verify contents of data frame
str(d)

# Split data frame into vectors for use in panta rhei sankey package
source <- (d$source)
str(source)
sourcefac <- factor(source)
str(sourcefac)
sourcenum <- as.numeric(sourcefac)
sourcechr <- as.character(sourcenum)

target <- (d$target)
targetfac <- factor(target)
targetnum <- as.numeric(targetfac)
targetchr <- as.character(targetnum)

value <- (d$value)
value


fig <- plot_ly(
  type = "sankey",
  orientation = "h",
  
  node = list(
    label = sourcechr,
    color = c("blue", "blue", "blue", "blue", "blue", "blue"),
    pad = 15,
    thickness = 20,
    line = list(
      color = "black",
      width = 0.5
    )
  ),
  
  link = list(
    links$source <- as.character(links$sourcefac),
    links$target <- as.character(links$targetfac),
    value
  )
)
fig <- fig %>% layout(
  title = "Basic Sankey Diagram",
  font = list(
    size = 10
  )
)

fig

str(source)
str(sourcefac)
str(sourcenum)
str(sourcechr)