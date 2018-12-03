library(DT)

BetUI <- function(id) {
  ns <- NS(id)

  tagList(
    selectInput( ns("depart"), label = "From", choices = c()),
    selectInput( ns("arrivee"), label = "To", choices = c()),
    selectInput( ns("mois"), label = "Which month", choices = c()),
    actionButton(ns("button"), label = "Go"),
    textOutput(ns("cote")),
    DT::DTOutput(ns("raison"))
  )
}

BetModule <- function(input, output, session, data) {

  data <- reactive({data})
  output$cote <- paste0("The bet is ",fonction_cote(input$depart,input$arrivee,input$mois))
  output$rasion <- paste0("These trains have been delayed because ",fonction_raison(input$depart,input$arrivee,input$mois))

}

