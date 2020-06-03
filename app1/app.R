ui <- dashboardPage(
  tags$head(tags$script(src = "message-handler.js")),
  actionButton("Pull", "Pull apps from github"))

server = function(input, output, session) {
  observeEvent(input$do, {
    system("(cd /home/shiny/apps; git pull)")
  })
}

shinyApp(ui=ui, server=server)


