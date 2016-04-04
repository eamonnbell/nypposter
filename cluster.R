library(rjson)
library(dtwclust)

d <- fromJSON(file='~/Projects/nypposter/piece_series.json')
pieces <- fromJSON(file='~/Projects/nypposter/pieces.json')

d <- zscore(d[250:500])
# d <- lapply(d, reinterpolate, newLength = 180)

ctrl <- new("dtwclustControl", window.size = 20L, trace = TRUE)

ctrl@pam.precompute <- FALSE

kc.sbd <- dtwclust(data = d, k = 6, distance="sbd",
                     centroid = "shape", 
                     control = ctrl)

kc.sbd

#plot(kc.sbd,color="red")
centroids <- attributes(kc.sbd)$centers
clusters <- attributes(kc.sbd)$cluster

clustered <- data.frame(pieces[250:500], clusters)
