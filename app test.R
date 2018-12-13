library(shiny)
library(shinydashboard)

ui <- navbarPage("",
                 tabPanel("Project Presentation", 
                          fluidPage(
                            titlePanel("Win Money on your train delays!"),
                            mainPanel(
                              h3("You bought a train ticket but you are worry to arrive late?"),
                              h3("You think you can predict when a train is going to arrive late?"),
                              h3("You are bored with train delays and want to monetize your waiting time?"),
                              h3("You are bored with train delays and want to monetize your waiting time?"),
                              h2("Come and bet on our app!"),
                              h4("A team of incredible data scientists has performed deep analysis and came up with the best odds on the market. 
                                 They created this application to bet on a train delay.
                                 If you think that the train from Paris Montparnasse to Nantes that leaves tomorrow is going to arrive more than 15 minutes after its announced arrival time, place a bet on this application and win money if your prediction is true."),
                              h1("Team:"),
                              h2("Xavier de Boisredon - Tristan Mayer - Alexandre Miny de Tornaco - Hossein Talebi - Zigfrid Zvezdin")
                              )
                            )
                 ),
                 tabPanel("BET",
                          ),
                 tabPanel("Info")
)

                 

server <- function(input, output) {
  }
  

shinyApp(ui = ui, server = server)
  
  