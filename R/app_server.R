#' app_analysis
#'
#' @param input UI input
#' @param output server output
#' @param session number of session
#' @import shiny tidyverse dplyr tidyr
#' @importFrom DT renderDT
#' @export
#'
app_analysis <- function(input, output,session){
  updateSelectInput(session,
                    "gareD",
                    choices=trainpack::SNCF_regularite
                    %>% select(gare_de_depart) %>% distinct())
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

  dataset <- reactiveValues(x = c(100))
  dataset2 <- reactiveValues(x = c(100))
  axex <- reactiveValues(x = c(100))
  axey <- reactiveValues(x = c(100))

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
    d %>% gather(month,value,Jan:Dec) %>% ggplot() + aes(month,value,fill=Types) + geom_col() + scale_x_discrete(limits = month.abb)
  })


  output$dataset <- DT::renderDT({
    data()[1,]
  })
  output$dataset2 <- DT::renderDT({
    data2()
  })


}

#' app_map
#'
#' @param input UI input
#' @param output server output
#' @param session number of session
#'
#' @return map
#' @export

app_map <- function(input, output,session){
  updateSelectInput(session,
                    "gareD",
                    choices=trainpack::SNCF_regularite
                    %>% select(gare_de_depart) %>% distinct())
  data_gareD <- reactive({
    input$gareD

  })
  mapping <- eventReactive(input$go,{
    carto(data_gareD())
  })
  output$map <- renderPlot({
    mapping()
  })

}

#' app_game
#'
#' @param input UI input
#' @param output server output
#' @param session number of session
#'
#' @return betting
#' @export
#'
app_game <- function(input, output,session){
  updateSelectInput(session,
                    "gareD",
                    choices=trainpack::SNCF_regularite
                    %>% select(gare_de_depart) %>% distinct())
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
    paste("<h4>Since you bet",bet(),"euros","with an odd of",round(cote(),2),
          "your potential gain is ","<br> <h2> <font color=\"#FF0000\"> <b>",
          round(gain(),0),"euros")
  })


}


#' Main server function app_server
#'
#' @param input UI input
#' @param output server output
#'
#' @return application
#' @export
#'
app_server <- function(input, output) {
  callModule(app_game,"game")
  callModule(app_analysis,"analysis")
  callModule(app_map,"map")
  data_month <- reactive({
    which(month.abb == input$choix_date)
  })
  fct_art <- reactive({fonction_article(data_month())})
  articles <- eventReactive(input$go2,{fct_art()})
  output$monde <- renderText({
    paste("<h4> On average for the last 3 year and for this month, there were","<b> <font color=\"#FF0000\"> ", articles(),"</b> </font color=\"#FF0000\"> articles on LeMonde.fr containing the words 'greve SNCF'")
  })

  output$team <- renderText({
    paste("<h4>We are 5 passionate students willing to have some fun while waiting for our delayed trains","<h5> Xavier de Boisredon - Tristan Mayer - Alexandre Miny de Tornaco - Hossein Talebi - Zigfrid Zvezdin")
  })

  output$explication <- renderText({
    paste("<h5> This map shows all possible destinations from the selected departure trainstation. The color represents the likelihood of a train to be late. For example, if it is close to 10 it means that : one train out of ten is being late in that specific department.")
  })

  output$information_text <- renderText({

    paste("<h3>You bought a train ticket but you are worry to arrive late?
          <h3>You think you can predict when a train is going to arrive late?
          <h3>You are bored with train delays and want to monetize your waiting time?
          <h2>Come and bet on our app!
          <h4>A team of incredible data scientists has performed deep analysis of the SNCF datasets and came up with the best odds on the market.
          They created this application to bet on trains delays.
          If you think that the train your taking tomorrow is going to arrive more than 15 minutes after its announced arrival time, place a bet on this application and win money if your prediction is true."
    )

  })
}
