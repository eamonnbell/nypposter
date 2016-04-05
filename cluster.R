library(rjson)
library(dtwclust)

d <- fromJSON(file='~/Projects/nypposter/piece_series.json')
pieces <- fromJSON(file='~/Projects/nypposter/pieces.json')

d <- zscore(d[250:500])
# d <- lapply(d, reinterpolate, newLength = 180)

ctrl <- new("dtwclustControl", window.size = 20L, trace = TRUE)

ctrl@pam.precompute <- FALSE


## Equivalent to k-Shape
kc.sbd <- dtwclust(data = d, k = 6, type="partitional", distance="sbd",
                 centroid = "shape", 
                 control = ctrl)

kc.sbd

#plot(kc.sbd,color="red")
centroids <- attributes(kc.sbd)$centers
clusters <- attributes(kc.sbd)$cluster

clustered <- data.frame(pieces[250:500], clusters)


json.one <- toJSON(centroids[[1]])
json.two <- toJSON(centroids[[2]])
json.three <- toJSON(centroids[[3]])
json.four <- toJSON(centroids[[4]])
json.five <- toJSON(centroids[[5]])
json.six <- toJSON(centroids[[6]])

write(json.one, "~/Projects/nypposter/center1.json")
write(json.two, "~/Projects/nypposter/center2.json")
write(json.three, "~/Projects/nypposter/center3.json")
write(json.four, "~/Projects/nypposter/center4.json")
write(json.five, "~/Projects/nypposter/center5.json")
write(json.six, "~/Projects/nypposter/center6.json")

write(toJSON(clustered), "~/Projects/nypposter/clusters.json")


