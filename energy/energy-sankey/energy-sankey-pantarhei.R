# Load libraries
library(PantaRhei)
library(grid)

# Load data
nodes <- read.csv("energy-nodes.csv", sep = ',', strip.white = TRUE)
flows <- read.csv("energy-flows.csv", sep = ',', strip.white = TRUE)
palette <- read.csv("energy-palette.csv", sep = ',', strip.white = TRUE)

str(nodes)
head(nodes)

# Check flow balance
parse_nodes(nodes, verbose = TRUE)
parse_flows(flows, verbose = FALSE)
parse_palette(palette, verbose = TRUE)
check_balance(nodes, flows, tolerance = 0.01)
check_consistency(nodes, flows, palette = NULL)

# write.table(energy$nodes , file = "energy-nodes.csv")
# write.table(energy$flows , file = "energy-flows.csv")
# write.table(energy$palette , file = "energy-palette.csv")

# Sankey Plot
dblue <- "#00008B" # Dark blue

my_title <- "Energy Flow - 3 Cherry"
attr(my_title, "gp") <- grid::gpar(fontsize=18, fontface="bold", col=dblue)

# node style
ns <- list(type="arrow",gp=gpar(fill=dblue, col="white", lwd=2),
           length=0.7,
           label_gp=gpar(col=dblue, fontsize=8),
           mag_pos="label", mag_fmt="%.0f", mag_gp=gpar(fontsize=10,fontface="bold",col=dblue))

sankey(nodes, flows, palette,
       max_width=0.1, rmin=0.5,
       node_style=ns,
       page_margin=c(0.15, 0.05, 0.1, 0.1),
       legend=TRUE, title=my_title,
       copyright="leftbrainstuff@gmail.com")