library(spatstat)

data(cells)

x_coord_node <- cells$x
y_coord_node <- cells$y

ppp_vertex<-ppp(x_coord_node, y_coord_node)

edgs<-cbind(from, to) # matrix containing the edge relations (vertex 'from', vertex 'to')

ln_vertex<- linnet(ppp_vertex, edges=edgs)

# Matrix containing the minimum distance (throughout the network) between each pair of vertices
path_dist <- ln_vertex[["dpath"]] 