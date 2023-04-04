library(intensitynet)
library(spatstat)


# ----------------------------------------------- Section 3.3 ----------------------------------------------- 

# Create an intensitynet object from a linear point process object

data(chicago)
edges <- cbind(chicago[["domain"]][["from"]], chicago[["domain"]][["to"]])
node_coords <- data.frame(xcoord=chicago[["domain"]][["vertices"]][["x"]],
                          ycoord=chicago[["domain"]][["vertices"]][["y"]])

net <- igraph::graph_from_edgelist(edges)
adj_mtx <- as.matrix(igraph::as_adjacency_matrix(net))

chicago_df <- as.data.frame(chicago[["data"]][, -(3:4)])
intnet_chicago <- intensitynet(adjacency_mtx = adj_mtx,
                               node_coords = node_coords,
                               event_data = chicago_df)

#Output
summary(intnet_chicago)


# Create an intensitynet object from a linear point process object
library(shp2graph)
data(ORN)

rtNEL <- shp2graph::readshpnw(ORN.nt, ELComputed = TRUE)

nodes_orn <- rtNEL[[2]]
edges_orn <- rtNEL[[3]]
lenghts_orn <- rtNEL[[4]]
net_orn<-shp2graph::nel2igraph(nodelist = nodes_orn,
                               edgelist = edges_orn,
                               weight = lenghts_orn)

adj_mtx_orn <- as.matrix(igraph::as_adjacency_matrix(net_orn))
node_coords_orn <- shp2graph::Nodes.coordinates(nodes_orn)
intnet_orn <- intensitynet(adjacency_mtx = adj_mtx_orn,
                           node_coords = node_coords_orn,
                           event_data = matrix(ncol = 2))

#Output
attributes(intnet_orn)


# ----------------------------------------------- Section 3.4 ----------------------------------------------- 

# Network intensity function estimation (using the object intnet_chicago created previously)
intnet_chicago <- RelateEventsToNetwork(intnet_chicago)
g <- GetGraph(intnet_chicago)

# Output
class(g)
head(igraph::as_data_frame(g, what = "vertices"))
head(igraph::as_data_frame(g, what = "edges"))[1:5]
head(igraph::as_data_frame(g, what = "edges"))[6:12]


# Function ApplyWindow

sub_intnet_chicago <- ApplyWindow(intnet_chicago,
                                  x_coords = c(300, 900),
                                  y_coords = c(500, 1000))

# Output
c(igraph::gorder(GetGraph(intnet_chicago)),
  igraph::gsize(GetGraph(intnet_chicago)),
  nrow(GetEvents(intnet_chicago)))

c(igraph::gorder(GetGraph(sub_intnet_chicago)),
  igraph::gsize(GetGraph(sub_intnet_chicago)),
  nrow(GetEvents(sub_intnet_chicago)))


# ----------------------------------------------- Section 3.5 ----------------------------------------------- 

# Function ShortestPath
short_path <- ShortestPath(intnet_chicago,
                           node_id1 = "V1" ,
                           node_id2 = "V300")

short_path_intensity <- ShortestPath(intnet_chicago,
                                     node_id1 = "V1" ,
                                     node_id2 = "V300" ,
                                     weight = "intensity")

short_path_cartheft <- ShortestPath(intnet_chicago,
                                    node_id1 = "V1" ,
                                    node_id2 = "V300" ,
                                    weight = "cartheft")
# Output
short_path$path
short_path$total_weight

short_path_intensity$path
short_path_intensity$total_weight

short_path_cartheft$path
short_path_cartheft$total_weight


# Function PathTotalWeight
path <- c("V89", "V92", "V111", "V162", "V164")
# path <- c(89, 92, 111, 162, 164) # Alternatively

# Output
PathTotalWeight(intnet_chicago, path = path)
PathTotalWeight(intnet_chicago, path = path, weight = "intensity")
PathTotalWeight(intnet_chicago, path = path, weight = "robbery")


# ----------------------------------------------- Section 3.6 ----------------------------------------------- 

# Local autocorrelation function

intensity_vec <- igraph::vertex_attr(GetGraph(intnet_chicago))$intensity
data_moran <- NodeLocalCorrelation(intnet_chicago,
                                   dep_type = "moran" ,
                                   intensity = intensity_vec)

intnet_chicago <- data_moran$intnet

data_geary <- NodeLocalCorrelation(intnet_chicago,
                                   dep_type = "geary" ,
                                   intensity = intensity_vec)

intnet_chicago <- data_geary$intnet

data_getis <- NodeLocalCorrelation(intnet_chicago,
                                   dep_type = "getis" ,
                                   intensity = intensity_vec)

intnet_chicago <- data_getis$intnet

# Output
head(data_moran)
head(data_getis$correlation)
head(data_getis$correlation)


# Global autocorrelation function

NodeGeneralCorrelation(intnet_chicago,
                       dep_type = "covariance" ,
                       lag_max = 2,
                       intensity = intensity_vec)

NodeGeneralCorrelation(intnet_chicago,
                       dep_type = "correlation" ,
                       lag_max = 5,
                       intensity = intensity_vec)

NodeGeneralCorrelation(intnet_chicago,
                       dep_type = "correlation" ,
                       lag_max = 5,
                       intensity = intensity_vec,
                       partial_neighborhood = FALSE)


# ----------------------------------------------- Section 3.7 -----------------------------------------------

# Plot moran heatmap from specific nodes
PlotHeatmap(intnet_chicago,
            heat_type = "moran" ,
            net_vertices = c("V66", "V65", "V64",
                             "V84", "V98", "V101",
                             "V116", "V117", "V118"))

# Plot map with events
plot(intnet_chicago, show_events = TRUE)

# Plot the map and highlight the path with the lowest total intensity
short_path <- ShortestPath(intnet_chicago,
                           node_id1 = "V1" ,
                           node_id2 = "V300" ,
                           weight = "intensity")
plot(intnet_chicago, show_events = TRUE, path = short_path$path)

# Plot the neighborhood of an specific node with the surrounding events
PlotNeighborhood(intnet_chicago, node_id = "V100")

# ----------------------------------------------- Section 3.8 -----------------------------------------------

# Intensitynet object containing only the 'trespass' events
chicago_trespass <- chicago_df[chicago_df$marks == "trespass" ,]
trespass_intnet <- intensitynet(adj_mtx,
                                node_coords = node_coords,
                                event_data = chicago_trespass)

trespass_intnet <- RelateEventsToNetwork(trespass_intnet)

trespass_intensity <- igraph::vertex_attr(GetGraph(trespass_intnet), "intensity")

# Intensitynet object containing only the 'robbery' events
chicago_robbery <- chicago_df[chicago_df$marks == "robbery" ,]
robbery_intnet <- intensitynet(adj_mtx,
                               node_coords = node_coords,
                               event_data = chicago_robbery)

robbery_intnet <- RelateEventsToNetwork(robbery_intnet)

robbery_intensity <- igraph::vertex_attr(GetGraph(robbery_intnet), "intensity")

#Output
cor(trespass_intensity, robbery_intensity) # potential correlation between the nodewise intensities of trespass and robbery events


# Information about the network contained in the intensitynet object
g <- GetGraph(intnet_chicago)
degree <- igraph::degree(g)

#Output
head(degree)
max(degree)
head(igraph::betweenness(g))
head(igraph::edge_betweenness(g))
head(igraph::closeness(g))