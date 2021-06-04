# R Script to plot NATHERS star ratings

# Load libraries
library(ggplot2)
library(scales)

# Import raw data
energy <- read.csv(file="energy-nathers.csv")
head(energy)
energy

# Convert MJ/m^2/Annum to kWh for 3 cherry
## 1 kWh = 3.6MJ Assume 3 cherry is 200m^2 plan area
energy <- mutate(energy, kWhperDay = ((((energy$MJperm2perAnnum)/365)*200)/3.6))
energy
 
# Format Energy Statistics Plot
plot2 <- ggplot(data = energy, aes(x = StarRating)) + 
  coord_cartesian(ylim=c(0, 650)) +
  scale_x_reverse(labels = label_number(accuracy=1), breaks=c(1,2,3,4,5,6,7,7.5,8,9,10)) +
  scale_y_continuous(sec.axis = sec_axis(trans=~.*0.152207, name="kWh/Day (200m^2)"), name = "MJ/Annum") +
  geom_point(aes(x = StarRating, y = MJperm2perAnnum)) +
  geom_vline(xintercept = 4.5, linetype="solid", color = "blue", size=0.5) +
  theme(text=element_text(family="Tahoma")) +
  theme(panel.grid.minor=element_blank())

# Plot
plot2 + labs(title = "NATHERs mapped to Energy Use", subtitle = "https://www.nathers.gov.au/owners-and-builders/home-energy-star-ratings", x = "Star Rating", y = "MJ / m^2 / Annum")


