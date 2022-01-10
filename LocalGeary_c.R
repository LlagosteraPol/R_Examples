adj_mtx1 <- matrix(data = c(0,3,4,0, 3,0,5,0, 4,5,0,8, 0,0,8,0), nrow = 4)
adj_mtx2 <- matrix(data = c(0,3,4,0,9,  3,0,5,0,0,  4,5,0,8,0, 0,0,8,0,0,  9,0,0,0,0), nrow = 5)
adj_mtx3 <- matrix(data = c(0,1,1,0, 1,0,0,1, 1,0,0,1, 0,1,1,0), nrow = 4 )

adj_mtx <- adj_mtx3

g_w <- graph_from_adjacency_matrix(adj_mtx, mode = 'undirected', weighted = TRUE)
# Add node weights
g_w <- set_vertex_attr(g_w, name='intensity', valu=c(4,35,25,1))


adj_mtx <- igraph::as_adj(graph = g_w)
adj_listw <- spdep::mat2listw(adj_mtx)
nb <- adj_listw$neighbours

wq <- spdep::nb2listw(nb, style = "W")
W.matrix <- as(wq, "CsparseMatrix") # Matrix of space weights - queen

var <- c(4,35,25,1)
n <- length(nb) # number of neighbourhoods or polygons

CG <- numeric(n) 
for (i in c(1:n)) {
  CG[i] <- sum(W.matrix[i,] * (var [i] - var)^2)
}