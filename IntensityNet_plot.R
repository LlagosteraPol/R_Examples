rm(list = ls())

library(intensitynet)
library(ggplot2)


# ------------------------------ LOAD THE DATA# ------------------------------

#!!!!! ADD THE PROPER DATA PATH  !!!!!

# Adjacency matrix (undirected): Segmenting locations of the traffic network treated as the vertex set of the network.
castellon <- read.table(paste0(getwd(),"/Data/castellon.txt"), header=TRUE, row.names=1) # says first column are rownames

# Node coordinates: Georeferenced coordinates from 'castellon' nodes
nodes <- read.table(paste0(getwd(),"/Data/nodes.txt"), header=TRUE, row.names=1) # says first column are rownames

# Event (crime coordinates)
crimes <- read.table(paste0(getwd(),"/Data/crimes_corrected.txt"), header=TRUE, row.names=1) # says first column are rownames

# ---------------------------------------------------------------------------


intnet <- intensitynet(castellon, nodes, crimes) # Create an intensitynet object

g <- intnet$graph # Get the igraph object

# Calculate the shortest path between the vertices 'V1' and 'V300'
short_path <- ShortestPath(intnet,
                           node_id1 = "V1" ,
                           node_id2 = "V300")

vpath <- short_path$path # Get the path vertices

# Retrieve the edge id's of the path
pedges <- igraph::E(g, path = vpath)

# Plot the shortest path
PlotHeatmap(intnet, net_vertices = vpath, net_edges = pedges)


# The PlotHeatmap function is based on ggplot2, therefore we can modify it using the ggplot2 characteristics
# For example, we can change the color of the nodes

# We create a dataframe from the points to color (in this case the vertices of the shortest path)
data_df <- data.frame(xcoord = vpath$xcoord, 
                      ycoord = vpath$ycoord)

# Retrieve the edges endpoint coordinates
edge_xcoords = igraph::vertex_attr(g, index=igraph::ends(g, pedges, names = TRUE)[,1])$xcoord
edge_ycoords = igraph::vertex_attr(g, index=igraph::ends(g, pedges, names = TRUE)[,1])$ycoord

edge_xcoords_end = igraph::vertex_attr(g, index=igraph::ends(g, pedges, names = TRUE)[,2])$xcoord
edge_ycoords_end = igraph::vertex_attr(g, index=igraph::ends(g, pedges, names = TRUE)[,2])$ycoord

# Create a dataframe with such coordinates
edges_df <- data.frame(xcoord = edge_xcoords,
                       ycoord = edge_ycoords,
                       xend = edge_xcoords_end,
                       yend = edge_ycoords_end)

# And then we paint in red the vertices using the ggplot2 function 'geom_point'
#  and the edges in blue with 'geom_segment'
PlotHeatmap(intnet,  net_edges = pedges) + 
  geom_segment(aes_string(x = 'xcoord', y = 'ycoord', 
                          xend = 'xend', yend = 'yend'),
               data = edges_df,
               size = 1.5,
               colour = "blue") +
  geom_point(data = data_df, 
             mapping = aes(x = vpath$xcoord, y = vpath$ycoord),
             size = 2,
             colour = "red")
  

