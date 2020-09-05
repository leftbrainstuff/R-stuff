# R Script to plot 9 Henry Court Solar and Energy Data

# Load libraries
library(ggplot2)
library(reshape2)
library(lubridate)
library(dplyr)

# Import raw data
energy <- read.csv(file="energy-water.csv")
head(energy)
energy

# Format date column
cleandates <- as.Date(energy[,1], format="%d %b %y")
head(cleandates)

# Replace date column with well formed dates
energy[,1] <- cleandates
head(energy)
energy

# Calculate day deltas
energy <- mutate(energy, daydelta = energy$date - lag(energy$date, 1))
energy$daydelta <- as.numeric(energy$daydelta, units="days") # Convert from difftime to integer

# Zero columns
energy$fgkwh <- energy$fgkwh - 5605.7
energy$tokwh <- energy$tokwh - 7234.0
energy$solarkwh <- energy$solarkwh - 10302
summary(energy)

# Calculate daily deltas
energy <- mutate(energy, fgkwh = energy$fgkwh - lag(energy$fgkwh, 1))
energy <- mutate(energy, tokwh = energy$tokwh - lag(energy$tokwh, 1))
energy <- mutate(energy, solarkwh = energy$solarkwh - lag(energy$solarkwh, 1))
head(energy)
energy
energy <- mutate(energy, daydelta = energy$date - lag(energy$date, 1))
energy$daydelta <- as.numeric(energy$daydelta, units="days") # Convert from difftime to integer
energy <- mutate(energy, fgdelta = fgkwh / energy$daydelta, label = "fgdelta") #%>% round(.,1)
energy <- mutate(energy, todelta = tokwh / energy$daydelta, label = "todelta")
energy <- mutate(energy, solarusage = solarkwh / energy$daydelta, label = "solarusage")
head(energy)
energy

# Energy delta
energy <- mutate(energy, gridusage = (energy$fgkwh - energy$tokwh)/energy$daydelta) # Net grid energy into house
energy <- mutate(energy, solarexcess = (energy$solarkwh - energy$fgkwh)/energy$daydelta) # Solar sent to grid
energy <- mutate(energy, solargeneration = (energy$solarkwh)/energy$daydelta) # Solar generation

# Format Energy Use Plot
plot <- ggplot(data = energy, aes(x = date)) + 
scale_y_continuous(name="kWhr", limits=c(-15, 25)) +
geom_smooth(aes(x = date, y = gridusage, color = "gridusage")) + 
geom_smooth(aes(x = date, y = solarexcess, color = "solarexcess")) +
geom_smooth(aes(x = date, y = solarusage, color = "solargeneration")) +
theme(text=element_text(family="Tahoma"))
 
# Plot
plot + labs(title = "Residential Energy Use", subtitle = "Solar Generation and Grid Energy Use", x = "Date", y = "kWh", caption = "Data: energy")

# Format Energy Statistics Plot
plot2 <- ggplot(data = energy, aes(x = date)) + 
  scale_y_continuous(name="kWhr", limits=c(-10, 50)) +
  #geom_point(aes(y = gridusage, color = "gridusage")) + 
  #geom_point(aes(x = date, y = solarexcess, color = "solarexcess")) +
  #geom_point(aes(x = date, y = solarusage, color = "solargeneration")) +
  geom_smooth(aes(y = gridusage, color = "gridusage")) + 
  geom_smooth(aes(x = date, y = solarexcess, color = "solarexcess")) +
  geom_smooth(aes(x = date, y = solarusage, color = "solargeneration")) +
  facet_grid(. ~ usecase, margins = TRUE) +
  theme(text=element_text(family="Tahoma"))

# Plot
plot2 + labs(title = "Residentual Energy Use", subtitle = "Solar Generation and Grid Energy Use", x = "Date", y = "kWh", caption = "Data: energy")


