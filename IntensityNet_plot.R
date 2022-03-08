rm(list = ls())

library(intensitynet)
library(ggplot2)


# Adjacency matrix (undirected): Segmenting locations of the traffic network treated as the vertex set of the network.
castellon <- read.table(paste0(getwd(),"/Data/castellon.txt"), header=TRUE, row.names=1) # says first column are rownames

# Node coordinates: Georeferenced coordinates from 'castellon' nodes
nodes <- read.table(paste0(getwd(),"/Data/nodes.txt"), header=TRUE, row.names=1) # says first column are rownames

# Event (crime coordinates)
crimes <- read.table(paste0(getwd(),"/Data/crimes_corrected.txt"), header=TRUE, row.names=1) # says first column are rownames

intnet_und <- intensitynet(castellon, nodes, crimes)

PlotHeatmap(intnet_und) + 
  geom_point(data = crimes, 
             mapping = aes(x = xcoord, y = ycoord, color = 'red'))