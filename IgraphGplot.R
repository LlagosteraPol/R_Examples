library(igraph)
library(ggplot2)

d <- data.frame(p1=c('a', 'a', 'a', 'b', 'b', 'b', 'c', 'c', 'd'),
                p2=c('b', 'c', 'd', 'c', 'd', 'e', 'd', 'e', 'e'))

g <- graph.data.frame(d, directed=FALSE)
plot(g, e=TRUE, v=TRUE)


  