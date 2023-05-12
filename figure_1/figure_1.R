library(ggplot2)
library(cowplot)
library(lemon)


#data from literture search, see file how_to_be_a_fig_nematode_supplemental_tables.xlsx sheet 1
dat <- read.table("fig_worm_species_year_data.csv", header=TRUE, sep="\t")

dat <- na.omit(dat)

daty <- aggregate(number_new_species ~ year, data=dat,sum)

daty$cum.sum <- cumsum(daty$number_new_species)

#with all nematodes data (from Nemys database; https://nemys.ugent.be/aphia.php?p=stats_graph&type=discovery&id=799&export=1 ; https://nemys.ugent.be/aphia.php?p=stats)

nema <- read.csv("Discovery_rate_figure_1.csv", header=TRUE)

nema$cum.sum <- nema$cumulative_new_species

nema$year <- nema$Year


datbin <- data.frame(year = daty$year, cum.sum = daty$cum.sum)

nemabin <- data.frame(year = nema$year, cum.sum = nema$cum.sum)

datbin$data.set <- "Fig nematodes"
nemabin$data.set <- "All nematodes"

alldat <- rbind(datbin,nemabin)

alldat$log.cum.sum <- log(alldat$cum.sum)

alldat_since_1973 <- alldat[alldat$year > 1972,]

ggplot(alldat_since_1973, aes(x=year,y=cum.sum)) + geom_line(aes(colour=data.set)) + facet_rep_grid(rows = vars(data.set),scales = "free") + theme_cowplot() + xlab("Year") + ylab("Cumulative number of species") + scale_x_continuous(limits=c(1970,2025),breaks=c(1970,1975,1980,1985,1990,1995,2000,2005,2010,2015,2020,2025)) + theme(legend.position="none", strip.background = element_rect(fill = "white"),axis.text.x = element_text(angle = 45, hjust=1)) + scale_colour_manual(values=c("darkorange2","dodgerblue3"))



#ggsave("fig_species_over_time_v2.png", units="in", width=6, height=4,bg='#ffffff')










