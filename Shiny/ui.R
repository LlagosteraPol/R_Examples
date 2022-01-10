
ui <- fluidPage(
  useShinyjs(),
  
  div(id = "file_panel",
      h1("Choose files"),
  ),
  
  hidden(
    div(id = "load_panel",
        h1("LOADING...")
    )
  ),
  
  hidden(
    div(id = "net_panel",
        h1("HIIII")
    )
  )
)