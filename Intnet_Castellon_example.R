#devtools::install_github("LlagosteraPol/intensitynet") # install package from github

library(intensitynet)

# Adjacency matrix (undirected): Segmenting locations of the traffic network treated as the vertex set of the network.
castellon <- read.table("Data/castellon.txt", header=TRUE, row.names=1) # says first column are rownames

# Node coordinates: Georeferenced coordinates from 'castellon' nodes
nodes <- read.table("Data/nodes.txt", header=TRUE, row.names=1) # says first column are rownames

crimes <- read.table("Data/crimes_corrected.txt", header=TRUE, row.names=1) 


# cast_node_coords_int <- cbind(as.numeric(sub(",", ".", c(cast_node_coords[[1]]))),
#                               as.numeric(sub(",", ".", c(cast_node_coords[[2]]))))

intnet_cast2 <- intensitynet(castellon,
                             node_coords = nodes,
                             event_data = crimes,
                             event_correction = 100)


# Calculate nodewise and edgewise intensities and mark proportions
intnet_cast2 <- RelateEventsToNetwork(intnet_cast2)


edge_data2<- as.data.frame(igraph::edge_attr(intnet_cast2$graph))

dim(edge_data2[edge_data2$n_events==0,])

dim(edge_data2[edge_data2$n_events>0,])


PlotHeatmap(intnet_cast2, heat_type='geary')