
# Local Geary-c 
# See: A Local Indicator of Multivariate SpatialAssociation: Extending Geary’s c, from Luc Anselin
# Check .pdf 'Geary_c_GeneralAndLocal'

library(igraph)
library(Matrix)


#---------------------------Get matrix from igraph object---------------------------
adj_mtx <- matrix(data = c(0,1,1,0, 1,0,0,1, 1,0,0,1, 0,1,1,0), nrow = 4 )

g_w <- graph_from_adjacency_matrix(adj_mtx, mode = 'undirected', weighted = TRUE)
# Add node weights
g_w <- set_vertex_attr(g_w, name='intensity', valu=c(4,35,25,1))


adj_mtx <- igraph::as_adj(graph = g_w)
adj_listw <- spdep::mat2listw(adj_mtx)
nb <- adj_listw$neighbours

wq <- spdep::nb2listw(nb, style = "W")
nb_B <- spdep::listw2mat(wq)

#----------------------------------------------------------------------------------

#nb_B <- matrix(c(0,0.5,.5,0,.5,0,0,.5,.5,0,0,.5,0,.5,.5,0),4,4 ) # Or get matrix directly
B <- as(nb_B, "CsparseMatrix")
all(B == t(B))

val.list <- c(4,35,25,1)
val <- scale(val.list)[,1]

# scale, with default settings, will calculate the mean and standard deviation of the entire vector,
# then "scale" each element by those values by subtracting the mean and dividing by the sd
val1 <-  (val.list - mean(val.list)) / sd(val.list) # same as scale() # sd = standard deviation

n <- 4
CG <- numeric(n)
for (i in c(1:n)) {
  CG[i] <- sum(B[i,] * (val[i] - val)^2)
}

# General Geary-c:
general <- sum(CG)/(2*sum(nb_B))

#--------------------------------------Comprovation:---------------------------------------
g_w <- graph_from_adjacency_matrix(nb_B, mode = 'undirected', weighted = TRUE)
plot(g_w, e=TRUE, v=TRUE)

g_sna <- intergraph::asNetwork(g_w)
general_ref <- sna::nacf(g_sna, c(4,35,25,1), type = 'geary', mode = "graph")[2]
#------------------------------------------------------------------------------------------
