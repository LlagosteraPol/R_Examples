library(shinyglide)

ui <- fluidPage(
  glide(
    disable_type = "hide",
    
    screen(
      p("Do you want to see the next screen ?"),
      checkboxInput("check", "Yes, of course !", value = FALSE)
    ),
    screenOutput("check_screen"),
    screen(
      p("And this is the last screen")
    )
  )
)

server <- function(input, output, session) {
  output$check_screen <- renderUI({
    Sys.sleep(2)
    if(!input$check) return(NULL)
    p("Here it is !")
  })
  outputOptions(output, "check_screen", suspendWhenHidden = FALSE)
}

shinyApp(ui, server)