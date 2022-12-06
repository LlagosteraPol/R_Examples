#With the function readShapeLines() from the maptools package, we can read a shapefile and store it 
#into an SpatialLinesDataFrame object (sp). In this example we use the data provided by the same package 
#shp2graph named 'ORN' which is already in sp format, therefore we don't need to use the maptools library 
#to read the shapefile.

library(intensitynet)
library(shp2graph) #Load library
data(ORN) #Load the Ontario road data from the shp2graph package

rtNEL <- shp2graph::readshpnw(ORN.nt, ELComputed=TRUE) 

nodes_orn <- rtNEL[[2]] 
edges_orn <- rtNEL[[3]] 
lengths_orn <- rtNEL[[4]] #edge lengths


net_orn<-shp2graph::nel2igraph(nodelist = nodes_orn,
                               edgelist = edges_orn,
                               weight = lengths_orn)


#Extract the network adjacency matrix
adj_mtx_orn <- as.matrix(igraph::as_adjacency_matrix(net_orn))


#Extract the network node coordinates
node_coords_orn <-  shp2graph::Nodes.coordinates(nodes_orn)

intnet_orn <- intensitynet(adjacency_mtx = adj_mtx_orn, 
                           node_coords = node_coords_orn, 
                           event_data = matrix(ncol = 2))

#We can plot the network to see if the data is correct
PlotHeatmap(intnet_orn) 