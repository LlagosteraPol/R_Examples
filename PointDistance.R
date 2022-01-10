library(spatstat)

data(cells)

x_coord_node <- cells$x
y_coord_node <- cells$y

distances_mtx <- pairdist(ppp(x_coord_node,
                              y_coord_node,
                              xrange=c(min(as.numeric(x_coord_node)), max(as.numeric(x_coord_node))),
                              yrange=c(min(as.numeric(y_coord_node)), max(as.numeric(y_coord_node)))))