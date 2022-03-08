devtools::install_github("LlagosteraPol/intensitynet") # install package from github

library(intensitynet)
library(spatstat)
data(chicago)


chicago_df <- as.data.frame(chicago[["data"]]) # Get as dataframe the data from Chicago

# Get the adjacency matrix. One way is to create an igraph object from the edge coordinates.
edges <- cbind(chicago[["domain"]][["from"]], chicago[["domain"]][["to"]])
chicago_net <- igraph::graph_from_edgelist(edges)

# And then use the igraph function 'as_adjacency_matrix'
chicago_adj_mtx <- as.matrix(igraph::as_adjacency_matrix(chicago_net))
chicago_node_coords <- data.frame(xcoord = chicago[["domain"]][["vertices"]][["x"]], 
                                  ycoord = chicago[["domain"]][["vertices"]][["y"]])

# Create the intensitynet object, in this case will be undirected 
intnet_chicago <- intensitynet(chicago_adj_mtx, 
                               node_coords = chicago_node_coords, 
                               event_data = chicago_df)

intnet_chicago <- RelateEventsToNetwork(intnet_chicago)

data_geary <- NodeLocalCorrelation(intnet_chicago, dep_type = 'geary', intensity = igraph::vertex_attr(intnet_chicago$graph)$intensity)
geary_c <- data_geary$correlation
intnet_chicago <- data_geary$intnet

PlotHeatmap(intnet_chicago, heattype='geary')
plot(intnet_chicago, enable_grid = TRUE, show_events = TRUE)


edge_data <- as.data.frame(igraph::edge_attr(intnet_chicago$graph))
node_data <- as.data.frame(igraph::vertex_attr(intnet_chicago$graph))

print(edge_data[15,])
print(node_data[1,])

