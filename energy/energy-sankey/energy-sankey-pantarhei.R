# Load libraries
library(PantaRhei)
library(grid)

# Load data
data(MFA) # Material Flow Account data
str(MFA)
head(MFA)

write.table(MFA$nodes , file = "mfa-nodes.csv")
write.table(MFA$flows , file = "mfa-flows.csv")
write.table(MFA$palette , file = "mfa-palette.csv")

# Sankey Plot
dblue <- "#00008B" # Dark blue

my_title <- "Material Flow Account"
attr(my_title, "gp") <- grid::gpar(fontsize=18, fontface="bold", col=dblue)

# node style
ns <- list(type="arrow",gp=gpar(fill=dblue, col="white", lwd=2),
           length=0.7,
           label_gp=gpar(col=dblue, fontsize=8),
           mag_pos="label", mag_fmt="%.0f", mag_gp=gpar(fontsize=10,fontface="bold",col=dblue))

sankey(MFA$nodes, MFA$flows, MFA$palette,
       max_width=0.1, rmin=0.5,
       node_style=ns,
       page_margin=c(0.15, 0.05, 0.1, 0.1),
       legend=TRUE, title=my_title,
       copyright="Statistics Netherlands")