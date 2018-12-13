#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyverse)

app_analysisUI <- function(id){

  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("gareD"),
                    label = "choose your depart station",
                    choices =  trainpack::SNCF_regularite
                    %>% select(gare_de_depart) %>% distinct()),
        selectInput(ns("gareA"),
                    label = "choose your destination station",
                    choices ="" ),
        selectInput(ns("mois"),label = "Month",choices = month.abb),
        selectInput(ns("axeX"),label = "Axe X ",choices = c("Reason of delay","Time of delay","Period")),
        conditionalPanel(paste0("input['",
                                ns("axeX"),
                                "'] == 'Period' ")
                         ,
                         selectInput(ns("axeY"), "Axe Y", choices = c("Proportion of reasons of delay","Proportion of times of delay"),selected ="Proportion of reasons of delay" )
        ),
        actionButton(inputId = ns("go"),label = "Go",icon = icon("GO"))
      ),

      mainPanel(
        conditionalPanel(paste0("input['",
                                ns("axeX"),
                                "'] != 'Period' "),
                         tabsetPanel(
                           tabPanel(title = "Graph",
                                    plotOutput(ns("plot_delay"))
                           ),
                           tabPanel(title = "Data",
                                    DT::DTOutput(ns("dataset"))
                           )
                         )

        ),
        conditionalPanel(paste0("input['",
                                ns("axeX"),
                                "'] == 'Period' "),
                         tabsetPanel(
                           tabPanel(title = "Graph",
                                    plotOutput(ns("plot_delay2"))
                           ),
                           tabPanel(title = "Data",
                                    DT::DTOutput(ns("dataset2"))
                           )
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
        selectInput(ns("gareD"),
                    label = "choose your depart station",
                    choices =  trainpack::SNCF_regularite
                    %>% select(gare_de_depart) %>% distinct()),
        selectInput(ns("gareA"),
                    label = "choose your destination station",
                    choices ="" ),
        selectInput(ns("mois"),label = "Month",choices = month.abb),
        numericInput(ns("bet"),label = " Choose youre bet",
                     value = 50, min = 0, max = 100000, step = 1),
        actionButton(inputId = ns("go"),label = "Go",icon = icon("GO"))
      ),

      mainPanel(
        htmlOutput(ns("Result")
        )

      )
    )
  )
}


app_analysis <- function(input, output,session){
  observe({
    updateSelectInput(session,
                      "gareA",
                      choices=trainpack::SNCF_regularite %>% filter(gare_de_depart == input$gareD)
                      %>% select(gare_d_arrivee) %>% distinct() %>% pull())
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
  data_axeX <- reactive({
    input$axeX
  })
  data_axeY <- reactive({
    input$axeY
  })

  dataset <- reactiveValues(x =rnorm(100))
  dataset2 <- reactiveValues(x= rnorm(100))
  axex <- reactiveValues(x =rnorm(100))
  axey <- reactiveValues(x =rnorm(100))

  observe({
    if( data_axeX() == "Reason of delay" ){
      dataset$x <- fonction_raison(data_gareD(),data_gareA(),data_month())
      axex$x <- "Different reasons of delay"
      axey$x <- "Proportion of reasons of delay"
    } else if ( data_axeX() == "Time of delay" ) {
      dataset$x <- delay_propr(data_gareD(),data_gareA(),data_month())
      axex$x <- "Different times of delay"
      axey$x <- "Proportion of times of delay"
    }
    else if ( data_axeX() == "Period" && data_axeY() == "Proportion of reasons of delay") {
      a <- data.frame(as.numeric(fonction_raison(data_gareD(),data_gareA(),1)))
      for (i in 2:12) {
        a <- data.frame(a,as.numeric(fonction_raison(data_gareD(),data_gareA(),i)))
      }
      names(a) <- month.abb
      a <- data.frame(names(fonction_raison("PARIS MONTPARNASSE", "NANTES", 4)),a)
      names(a)[1] <- "Types"
      dataset2$x <- a
      axex$x <- "Period"
      axey$x <- "Proportion of reasons of delay"
    }
    else if ( data_axeX() == "Period" && data_axeY() == "Proportion of times of delay") {
      a <- data.frame(as.numeric(delay_propr(data_gareD(),data_gareA(),1)))
      for (i in 2:12) {
        a <- data.frame(a,as.numeric(delay_propr(data_gareD(),data_gareA(),i)))
      }
      names(a) <- month.abb
      a <- data.frame(names(delay_propr("PARIS MONTPARNASSE", "NANTES", 4)),a)
      names(a)[1] <- "Types"
      dataset2$x <- a
      axex$x <- "Period"
      axey$x <- "Proportion of times of delay"
    }
  })
  data <- eventReactive(input$go,{
    dataset$x
  })
  data2 <- eventReactive(input$go,{
    dataset2$x
  })

  ax <- eventReactive(input$go,{
    axex$x
  })
  ay <- eventReactive(input$go,{
    axey$x
  })

  output$plot_delay <- renderPlot({
    d<- data()
    df <- data.frame(x= names(d),y = d [1,] )
    ggplot(data = df,aes( x = names(d), y= as.numeric(d[1,]))) +
      geom_bar(stat = "identity",fill="steelblue") +
      xlab(ax()) + ylab(ay()) + theme_minimal() +
      theme(axis.text=element_text(size=14,face="bold"),
            axis.title.x  =element_text(size=14,face="bold",vjust = -1),
            axis.title.y  =element_text(size=14,face="bold",vjust= 3)) +
      theme(axis.text.x = element_text(angle=60, hjust=1))
  })

  output$plot_delay2 <- renderPlot({
    d<- data2()
    d %>% gather(month,value,Jan:Dec) %>% ggplot() + aes(month,value,fill=Types) + geom_col()
  })


  output$dataset <- DT::renderDT({
    data()[1,]
  })
  output$dataset2 <- DT::renderDT({
    data2()
  })


}


app_game <- function(input, output,session){
  observe({
    updateSelectInput(session,
                      "gareA",
                      choices=trainpack::SNCF_regularite %>% filter(gare_de_depart == input$gareD)
                      %>% select(gare_d_arrivee) %>% distinct() %>% pull())
  })
  data_month <- reactive({
    req(input$mois)
    which(month.abb == input$mois)

  })
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

  gain <- eventReactive(input$go,{fonction_cote(data_gareD(),data_gareA(),data_month()) * data_bet()})

  cote <- eventReactive(input$go,{fonction_cote(data_gareD(),data_gareA(),data_month())})

  bet <- eventReactive(input$go,{data_bet()})

  output$Result <- renderText({
    paste("<h4>Since you bet",bet(),"€","with a rate of",round(cote(),2),
          "your potential gain is ","<br> <h2> <font color=\"#FF0000\"> <b>",
          round(gain(),0),"€")
  })


}



ui <- dashboardPage(skin="green",
                    dashboardHeader( title = "Train Betting App"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Presentation",tabName = "Presentation", icon = icon("home")),
                        menuItem("Bet",tabName = "Bet", icon = icon("money")),
                        menuItem("Information",tabName = "Information", icon = icon("info"))

                      )),

                    dashboardBody(
                      tags$head(tags$style(HTML('
                                .main-header .logo {
                                                font-family: "Georgia", Times, "Times New Roman", serif;
                                                font-weight: bold;
                                                font-size: 20px;
                                                }
                                                '))),
                      tabItems(

                        tabItem(tabName ="Presentation" ,
                                fluidPage(


                                  box(width = 16,
                                      htmlOutput("information_text")
                                  )
                                )),
                        tabItem ( tabName = "Bet",
                                  app_gameUI("game")

                        ),
                        tabItem ( tabName = "Information",
                                  app_analysisUI("analysis")

                        )


                      )
                    )
)


server <- function(input, output) {
  callModule(app_game,"game")
  callModule(app_analysis,"analysis")
  output$information_text <- renderText({
    paste("<h4> BLA BLA BLA
          La régularité TGV tient compte des différentes durées de trajet des clients (aussi appelée composite).
          Un train est considéré à l'heure si son retard au terminus estDécouvrez la régularité mensuelle TGV par liaisons (AQST).
          La régularité TGV tient compte des différentes durées de trajet des clients (aussi appelée composite).
          Un train est considéré à l'heure si son retard au terminus est inférieur à 5min pour un parcours inférieur à 1h30
          Un train est considéré à l'heure si son retard au terminus est inférieur à 10min pour un parcours entre 1h30 et 3h
          Un train est considéré à l'heure si son retard au terminus est inférieur à 15min pour un parcours au-delà de 3h
          Les horaires d'arrivée sont également déterminés par des capteurs détectant le passage du train à un point déterminé marquant l'entrée en gare et exceptionnellement par des suivis manuel. La précision des mesures est la minute arrondie à minute inférieure, ce qui est conforme à l'ensemble des normes retenues pour la confection des horaires et chronogrammes de service.")
  })
}
shinyApp(ui,server)
