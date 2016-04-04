library(rjson)
library(dtwclust)
library(ape)
library(RColorBrewer)
library(colorspace)


d <- fromJSON(file='~/Projects/nypposter/series.json')
composers <- fromJSON(file='~/Projects/nypposter/composers.json')

d <- d[1:50]
composers <- composers[1:50]

datalist <- zscore(d)

ctrl <- new("dtwclustControl", window.size = 20L, trace = TRUE)

ctrl@pam.precompute <- FALSE

hc.sbd <- dtwclust(datalist, type = "hierarchical",
                   k = 19:21, distance = "sbd",
                   method = "all")

ward <- hc.sbd[[1]]


p <- as.phylo(ward)

custom_split <- strsplit(composers, ",")
composers_last <- sapply(custom_split, "[", 1)
  
p$tip.label <- composers_last

midpoints <- fromJSON(file='~/Projects/nypposter/midpoints.json')
ix <- sort.int(midpoints, index.return=TRUE)$ix

#svg("~/Projects/nypposter/figs/fan.svg")
plot(p, type='fan', font=2, tip.color=pal(ix))
#dev.off()