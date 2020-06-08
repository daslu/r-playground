library(shiny)

ui <- fluidPage(
  tags$head(tags$script(src = "message-handler.js")),
  titlePanel("~~~~"),
  actionButton("Pull", "Pull apps from github"))

server = function(input, output, session) {
  observeEvent(input$do, {
    system(touch "/tmp/a")
    #system("(cd /home/shiny/apps; git pull)")
  })
}

shinyApp(ui=ui, server=server)


