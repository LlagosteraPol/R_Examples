library(shiny)

ui <- fluidPage(
  actionButton("btn", "Click"),
  actionButton("btn2", "Next"),
  uiOutput("ui1"),
  uiOutput("ui2"),
  uiOutput("ui3")
)

server <- function(input, output, session) {
  
  output$ui1 <- renderUI({
    if (input$btn == 0) return(div())
    else shinycssloaders::withSpinner(tableOutput("table"))
  })
  
  output$table <- renderTable({
    req(input$btn)
    Sys.sleep(2)
    head(mtcars)
  })
  
  output$ui2 <- renderUI({
    if (input$btn2 == 0) return(div())
    else{
      output$ui1 <- renderUI({div()})
      div(h1("Hello"),
      sidebarPanel( width = 12,
                    fileInput(inputId = "data_adjacency",label = "Load Adjacency Matrix :", accept = ".RData"),
                    fileInput(inputId = "data_coordinates", label = "Load Node Coordinates", accept = ".RData"),
                    fileInput(inputId = "data_events", label = "Load Event Coordinates", accept = ".RData")
      )
      )
    }
  })
}

shinyApp(ui, server)