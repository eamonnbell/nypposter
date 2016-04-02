library(rjson)
library(dtwclust)

d <- fromJSON(file='~/Projects/nypposter/series.json')

datalist <- zscore(d)
# data <- lapply(d, reinterpolate,newLength = 180)

ctrl <- new("dtwclustControl", window.size = 20L, trace = TRUE)

ctrl@pam.precompute <- FALSE

kc.sbd <- dtwclust(data = datalist, k = 7, distance = "sbd",
                     centroid = "pam", 
                     control = ctrl)
plot(kc.sbd)

centroids <- attributes(kc.sbd)$centers
