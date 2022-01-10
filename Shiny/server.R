library(shiny)
library(shinyjs) # Perform common useful JavaScript operations in Shiny 


changePanel <- function(panel) {
  if(panel == "file_panel"){show("file_panel") 
  } else{
    hide("file_panel")
  }
  
  if(panel == "load_panel"){
    show("load_panel") 
  }else {hide("load_panel")}
  if(panel == "net_panel") show("net_panel") else hide("net_panel")
  
  print(panel)
}

gen_net <- function(adj_mtx, node_coords, events){
  intnet <- intensitynet(adj_mtx, node_coords, events)
  intnet <- CalculateEventIntensities(intnet)
  intnet <- NodeLocalCorrelation(intnet, 'moran')
  intnet <- NodeLocalCorrelation(intnet, 'g')
  cat(paste(vertex_attr_names(intnet$graph), "\n"))
  #cat(paste(vertex_attr(intnet$graph)$xcoord[1], "\n"))
  g <- intnet$graph
  edge_ids <- get.edge.ids(g, as.vector(t(get.edgelist(g)))) 
  
  nodes <- data.frame(id = paste(vertex_attr(g)$name),
                      x = vertex_attr(g)$xcoord,
                      y = vertex_attr(g)$ycoord,
                      label = paste(vertex_attr(g)$name))
  
  edges <- data.frame(id = edge_ids,
                      from = get.edgelist(g)[,1],
                      to = get.edgelist(g)[,2])
  
  list(nodes = nodes, edges = edges, graph = g)
}

server <- function(input, output, session) {
  Sys.sleep(2)
  hide("file_panel")
  show("load_panel") 
}
