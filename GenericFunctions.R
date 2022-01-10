#-----------------------------------------PLOT EXAMPLE----------------------------------------

plot <- function(obj, ...){
  UseMethod('plot')
}

plot.genplot <- function(obj, ...){
  plot(obj$data, col='red')
}

# plot(genplot_obj)
# plot(cars, col='blue')


#-----------------------------------------GGPLOT EXAMPLE--------------------------------------
#TODO: Not working example
library(ggplot2)


ggplot <- function(obj, ...){
  UseMethod('ggplot')
}


ggplot.genplot <- function(obj, ...){
  values <- obj$data
  
  ggplot(data = values)
}

ggplot.default <- function(obj, ...){
  ggplot(obj, ...)
}

genplot_obj <- list(data = cars)
attr(genplot_obj, "class") <- 'genplot'

ggplot(genplot_obj)
# ggplot(data = mtcars) + 
#   geom_point(aes(mpg, qsec, colour = factor(am))) +
#   facet_grid(~vs)





