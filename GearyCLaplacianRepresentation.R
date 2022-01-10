library(igraph)

# For further details about the representation, refer to the paper: Yamada, H. Geary’s c and 
# Spectral Graph Theory. Mathematics 2021, 9, 2465. https://doi.org/10.3390/math9192465

adj_mtx1 <- matrix(data = c(0,3,4,0, 3,0,5,0, 4,5,0,8, 0,0,8,0), nrow = 4)
adj_mtx2 <- matrix(data = c(0,3,4,0,9,  3,0,5,0,0,  4,5,0,8,0, 0,0,8,0,0,  9,0,0,0,0), nrow = 5)
adj_mtx3 <- matrix(data = c(0,1,1,0, 1,0,0,1, 1,0,0,1, 0,1,1,0), nrow = 4 )

adj_mtx <- adj_mtx3
g_w <- graph_from_adjacency_matrix(adj_mtx, mode = 'undirected')
plot(g_w, e=TRUE, v=TRUE)

# Add node weights
g_w <- set_vertex_attr(g_w, name='intensity', valu=c(4,35,25,1))

l_mtx <- as.matrix(laplacian_matrix(g_w, weights = NA)) # Laplacian matrix (not weighted)
l_eigen <- eigen(l_mtx) # Eigenvalues and eigenvectors
#y <- round(tcrossprod(l_eigen[["vectors"]],l_eigen[["vectors"]]), 10) # y = U*U^T 
y <- t(matrix(c(4,35,25,1), nrow=1))

# Check that the 'U' (eigenvectors) is correct (L = U*lambda*U^T)
l_temp <- round(l_eigen[["vectors"]]%*%diag(l_eigen[["values"]])%*%t(l_eigen[["vectors"]]))
print(paste0("U is correct?: ", all(l_mtx == l_temp )))

omega <- sum(adj_mtx) # Sum(w_{ij}) I think is the sum of all 1's in the adjacency matrix

id_mtx <- diag(nrow(adj_mtx)) # Identity matrix (In)

ones <-as.matrix(rep(1, dim(adj_mtx)[1]), ncol=dim(adj_mtx)[1])
ones.t.ones <- crossprod(ones,ones) 

ql <- id_mtx - ones%*%solve(ones.t.ones)%*%t(ones) # Ql = In - l(l^T*l)^-1*l^T  # solve = inverse of a matrix (^-1)

# Check if ql is correct (l = ql*l*ql)
print(paste0("Ql is correct?: ", all(l_mtx == (ql%*%l_mtx%*%ql) )))

# c = ( (n-1) / omega) * ( (y^T*L*y) / (y^T*Q*y) )
c <- round(( ( length(V(g_w)) - 1 ) / omega ) * ( (t(y)%*%l_mtx%*%y) / (t(y)%*%ql%*%y) ), 5)
c
