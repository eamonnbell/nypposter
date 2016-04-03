d <- fromJSON(file='~/Projects/nypposter/series.json')
composers <- fromJSON(file='~/Projects/nypposter/composers.json')

d <- d[1:15]
composers <- composers[1:15]

d <- zscore(d)

df <- data.frame(ts=I(d))
rownames(df) <- composers


some <- unlist(d[4])
comp <- composers[4]
stl(some)