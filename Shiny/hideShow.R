library(shiny)
library(shinyjs)

load_data <- function() {
  Sys.sleep(2)
  hide("loading_page")
  show("main_content")
}

ui <- fluidPage(
  useShinyjs(),
  div(
    id = "loading_page",
    h1("Loading...")
  ),
  hidden(
    div(
      id = "main_content",
      "Data loaded, content goes here"
    )
  )
)

server <- function(input, output, session) {
  load_data()
}

shinyApp(ui = ui, server = server)