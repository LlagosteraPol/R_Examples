library(shiny)

ui <- fluidPage(
  actionButton("eval","Evaluate"),
  numericInput("num_input", "If number is changed, cp must hide", value = 0),
  conditionalPanel("input.eval && !output.hide_panel", "text")
)

server <- function(input, output, session) {
  
  output$hide_panel <- eventReactive(input$num_input, TRUE, ignoreInit = TRUE)
  
  outputOptions(output, "hide_panel", suspendWhenHidden = FALSE)
}

shinyApp(ui, server)