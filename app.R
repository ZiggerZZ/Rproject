## SHINY
library(dplyr)
library(ggplot2)

app_analysisUI <- function(id){
  
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("gareD"),label = "choose your depart station",choices = SNCF_regularite %>% select("Gare.de.départ") %>% distinct()),
        selectInput(ns("gareA"),label = "choose your destination station",choices = SNCF_regularite %>% select("Gare.d.arrivée") %>% distinct()),
        selectInput(ns("mois"),label = "Month",choices = month.abb),
        selectInput(ns("axeX"),label = "Axe X ",choices = c("Reason of delay","Time of delay")),
        actionButton(inputId = ns("go"),label = "Go",icon = icon("GO"))
      ),
      
      mainPanel(
        tabsetPanel(
          tabPanel(title = "Graph",
                   plotOutput(ns("plot_delay"))
          ),
          tabPanel(title = "Data",
                   DT::DTOutput(ns("dataset"))
          )
          
          
        )
        
      )
    )
  )
}
app_gameUI <- function(id){
  
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        checkboxGroupInput(inputId = ns("choix"),label = "delay or on time",choices = c("Delay" = "D", "On time" = "O"),selected = c("D")),
        selectInput(ns("gareD"),label = "choose your depart station",choices = SNCF_regularite %>% select("Gare.de.départ") %>% distinct()),
        selectInput(ns("gareA"),label = "choose your destination station",choices = SNCF_regularite %>% select("Gare.d.arrivée") %>% distinct()),
        selectInput(ns("mois"),label = "Month",choices = month.abb),
        numericInput(ns("bet"),label = " Choose youre bet",
          value = 50, min = 0, max = 100000, step = 1),
        actionButton(inputId = ns("go"),label = "Go",icon = icon("GO"))
      ),
      
      mainPanel(
        textOutput(ns("Result"))
      )
    )
  )
}


app_analysis <- function(input, output,session){
  
  data_month <- reactive({
    req(input$mois)
    which(month.abb == input$mois)

  })
  
  data_gareA <- reactive({
    input$gareA
  })
  
  data_gareD <- reactive({
    input$gareD
    
  })

  dataset <- reactiveValues(x = rnorm(100))
  observe({
    
    if( input$axeX == "Reason of delay" ){
      
      
      dataset$x <- fonction_raison(data_gareD(),data_gareA(),data_month()) 
    
    } else if ( input$axeX == "Time of delay" ) {
      
      dataset$x <- delay_propr(data_gareD(),data_gareA(),data_month())
    }
    
  })
  

  
  
  output$plot_delay <- renderPlot({
    d<- dataset$x
    df <- data.frame(x=names(d),y=as.numeric( d[1,]))
    ggplot(data = df,aes( x = x, y= y)) + 
      geom_bar(stat = "identity")
      })
  

  output$dataset <- DT::renderDT({
    d
  })
  

}


app_game <- function(input, output,session){
  
  data_bet <- reactive({
    req(input$bet)
    input$bet

  })
  data_month <- reactive({
    req(input$mois)
    which(month.abb == input$mois)
    
  })
  
  data_gareA <- reactive({
    input$gareA
  })
  
  data_gareD <- reactive({
    input$gareD
    
  })
  
  cote <- eventReactive(input$go,{
    fonction_cote(data_gareD(),data_gareA(),data_month()) 
  })
  
  output$Result <- renderText({
    glue::glue("The result is {cote()*data_bet()} ")
    })
  
  
}



ui <- fluidPage(
  navbarPage( "",tabPanel("Information",
                          mainPanel(
                          textOutput("information_text")  
                            )
                          )
             ,tabPanel("Analysis",app_analysisUI("analysis"))
             ,tabPanel("Betting",app_gameUI("game")
                       
                       )
             )
   )


server <- function(input, output) {
  callModule(app_analysis,"analysis")
  callModule(app_game,"game")
  output$information_text <- renderText({
    paste(" BLA BLA BLA 
          La régularité TGV tient compte des différentes durées de trajet des clients (aussi appelée composite).

          Un train est considéré à l'heure si son retard au terminus estDécouvrez la régularité mensuelle TGV par liaisons (AQST).
          La régularité TGV tient compte des différentes durées de trajet des clients (aussi appelée composite).
          Un train est considéré à l'heure si son retard au terminus est inférieur à 5min pour un parcours inférieur à 1h30
          Un train est considéré à l'heure si son retard au terminus est inférieur à 10min pour un parcours entre 1h30 et 3h
          Un train est considéré à l'heure si son retard au terminus est inférieur à 15min pour un parcours au-delà de 3h
          Les horaires d'arrivée sont également déterminés par des capteurs détectant le passage du train à un point déterminé marquant l'entrée en gare et exceptionnellement par des suivis manuel. La précision des mesures est la minute arrondie à minute inférieure, ce qui est conforme à l'ensemble des normes retenues pour la confection des horaires et chronogrammes de service.")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

