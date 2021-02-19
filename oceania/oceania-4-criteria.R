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
#library(lubridate)
#library(dplyr)
library(scales)
#library(scatterpie)
#library(hrbrthemes)
#library(viridis)

## Create plot ready data frames

## Source data
countrydata <- read.csv(file.choose())
# countrydata <- read.csv(file.choose())
countrydata <- data.frame(countrydata, fix.empty.names = TRUE, stringsAsFactors = TRUE) # build the countrydata df
str(countrydata) # check it was read and the df has data
head(countrydata)

## The plot
theme_update(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
p <- ggplot() + 
  #geom_point(aes(mobile_access, gov_exp_per_student, size=population, color=jnap_status), countrydata, alpha=0.5) + # for size=population
  #geom_point(aes(mobile_access, gov_exp_per_student, size=literacy_rate, color=jnap_status), countrydata, alpha=0.5) + # for size=literacy-rate
  #geom_point(aes(mobile_access, gov_exp_per_student, size=dataset_qty_keyword, color=jnap_status), countrydata, alpha=0.5) + # for dataset_qty_keyword
  geom_point(aes(mobile_access, gov_exp_per_student, size=cost_of_starting_business, color=jnap_status), countrydata, alpha=0.5) + # for cost_of_starting_business
  guides(color=guide_legend(override.aes = list(size=5))) +
  geom_text(aes(x=countrydata$mobile_access, y=countrydata$gov_exp_per_student, label=countrydata$country), colour="black", size=3) +
  #scale_size(range=c(8,20),breaks=c(10000,100000,1000000,10000000),labels=c(">=10k",">=100k",">=1M",">=10M"),guide="legend", name="Population") + # for size=population
  #scale_size(range=c(5,20),breaks=c(50,75,90,95),labels=c(">=50",">=75",">=90",">=95"),guide="legend") + # for size=literacy-rate
  #scale_size(range=c(3,20),breaks=c(100,1000,2000,3000,4000),labels=c(">=100",">=1k",">=2k",">=3k",">=4k"),guide="legend", name="Open Data Sets") + # for dataset_qty_keyword
  scale_size(range=c(3,20),breaks=c(10,20,50,75,90),labels=c(">=10",">=20",">=50",">=75",">=90"),guide="legend", name="Bus Start Cost (%Income/GNI)") + # cost_of_starting_business
  #scale_fill_viridis(scale_color_viridis_d(option = "magma", guide = guide_legend(override.aes = list(size = 3)))) +
  #theme_bw() +
  coord_cartesian() +
  scale_x_continuous(limits=c(0,max(countrydata$mobile_access))) +
  scale_y_continuous(limits=c(0,30)) +
  geom_vline(xintercept = 100) +
  #labs(x="Cellular Penetration (%)", y="Gov Exp / Student (%GDP)", caption = "(based on data from the World Bank, www.theglobaleconomy.com and Gov websites)", color="JNAP", size="Population") + # for size=population
  #labs(x="Cellular Penetration (%)", y="Gov Exp / Student (%GDP)", caption = "(based on data from the World Bank, www.theglobaleconomy.com and Gov websites)", color="JNAP", size="Literacy") + # for size=literacy-rate
  #labs(x="Cellular Penetration (%)", y="Gov Exp / Student (%GDP)", caption = "(based on data from the World Bank, www.theglobaleconomy.com and Gov websites)", color="JNAP", size="Open Data Sets") + # for dataset_qty_keyword
  labs(x="Cellular Penetration (%)", y="Gov Education Exp (%GDP)", caption = "(based on data from the World Bank, www.theglobaleconomy.com and Gov websites)", color="JNAP", size="Bus Start Cost (%Income/GNI)") + # for cost_of_starting_business
  ggtitle("Oceania Investment, Preparedness, Connectivity of Citizens", subtitle = "JNAP = Joint National Action Plan for Emergency Preparedness")
p

## Save plot as image
#ggsave("oceania-mobile-studexp-jnap-pop.png", device = NULL, dpi = 300, width = 8, height = 4.5) # for size=population
#ggsave("oceania-mobile-studexp-jnap-lit.png", device = NULL, dpi = 300, width = 8, height = 4.5) # for size=literacy-rate
#ggsave("oceania-mobile-studexp-jnap-data.png", device = NULL, dpi = 300, width = 8, height = 4.5) # for dataset_qty_keyword
ggsave("oceania-mobile-studexp-jnap-cosb.png", device = NULL, dpi = 300, width = 8, height = 4.5) # for cost_of_starting_business
