

adj_mtx1 <- matrix(data = c(0,3,4,0, 3,0,5,0, 4,5,0,8, 0,0,8,0), nrow = 4)
adj_mtx2 <- matrix(data = c(0,3,4,0,9,  3,0,5,0,0,  4,5,0,8,0, 0,0,8,0,0,  9,0,0,0,0), nrow = 5)
adj_mtx3 <- matrix(data = c(0,1,1,0, 1,0,0,1, 1,0,0,1, 0,1,1,0), nrow = 4 )

adj_mtx <- adj_mtx3

g_w <- graph_from_adjacency_matrix(adj_mtx, mode = 'undirected', weighted = TRUE)
plot(g_w, e=TRUE, v=TRUE)

g_sna <- intergraph::asNetwork(g_w)
sna::nacf(g_sna, c(4,35,25,1), type = 'geary', mode = "graph")