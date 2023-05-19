library(ggplot2)
library(DT)

datatable(iris)

#https://datatables.net/reference/option/dom

datatable(head(iris), class = 'cell-border stripe',options = list(dom = 'lt'))

datatable(head(iris), class = 'cell-border stripe')
