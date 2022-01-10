library(igraph)

adj_mtx2 <- matrix(data = c(0,3,4,0,9,  3,0,5,0,0,  4,5,0,8,0, 0,0,8,0,0,  9,0,0,0,0), nrow = 5)

adj_mtx <- matrix(data = c(0,3,4,0, 3,0,5,0, 4,5,0,8, 0,0,8,0), nrow = 4)
g_w <- graph_from_adjacency_matrix(adj_mtx, mode = 'undirected', weighted = TRUE)
plot(g_w, e=TRUE, v=TRUE)

#adj_mtx_ref <- as.matrix(as_adjacency_matrix(g_w, attr = 'weight'))

l_mtx <- as.matrix(laplacian_matrix(g_w, weights = NA)) # Laplacian matrix (not weighted)
l_eigen <- eigen(l_mtx) # Eigenvalues and eigenvectors
y <- tcrossprod(l_eigen[["vectors"]],l_eigen[["vectors"]]) # y = U*U^T

omega <- sum(edge_attr(g_w, 'weight'))

id_mtx <- diag(nrow(adj_mtx)) # Identity matrix (In)

ones <-as.matrix(rep(1, dim(adj_mtx)[1]), ncol=dim(adj_mtx)[1])
ones.t.ones <- crossprod(ones,ones) 

ql <- id_mtx - ones%*%solve(ones.t.ones)%*%t(ones) # Ql = In - l(l^T*l)^-1*l^T  # solve = inverse of a matrix (^-1)

# Check if ql is correct (l = ql*l*ql)
print(all(l_mtx == (ql%*%l%*%ql) ))

# c = ( (n-1) / omega) * ( (y^T*L*y) / (y^T*Q*y) )
c <- ( ( length(V(g_w)) - 1 ) / omega ) * ( (solve(y)%*%l_mtx%*%y) / (solve(y)%*%ql%*%y) )
c

