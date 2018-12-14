#' app_analysisUI
#'
#' @param id identificator
#'
#' @import shiny shinydashboard dplyr
#' @importFrom DT DTOutput
#' @export
app_analysisUI <- function(id){

  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("gareD"),
                    label = "choose your depart station",
                    choices =  ""),
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
#' app_MapUI
#'
#' @param id identificator
#'
#' @import shiny shinydashboard dplyr
#' @importFrom DT DTOutput
#' @export
app_MapUI <- function(id){

  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("gareD"),
                    label = "choose your station",
                    choices = ""),
        actionButton(inputId = ns("go"),label = "Go",icon = icon("GO"))),
      mainPanel(
        plotOutput(ns("map"))
      )

    )
  )
}
#' app_gameUI
#'
#' @param id identificator
#'
#' @import shiny shinydashboard dplyr
#' @importFrom DT DTOutput
#' @export
app_gameUI <- function(id){

  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(ns("gareD"),
                    label = "choose your depart station",
                    choices = ""),
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

#' app_ui
#'
#' @import shiny shinydashboard dplyr
#' @importFrom DT DTOutput
#' @export
app_ui <- dashboardPage(skin="green",
                    dashboardHeader( title = "Train Betting App"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Presentation",tabName = "Presentation", icon = icon("home")),
                        menuItem("Bet",tabName = "Bet", icon = icon("money")),
                        menuItem("Information",tabName = "Information", icon = icon("info")),
                        menuItem("Mapping",tabName = "Map", icon = icon("map"))

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
                                fluidRow(
                                  box(width = 16,
                                      htmlOutput("information_text"))),
                                fluidRow(

                                  box(width = 16,
                                      title = "The team",
                                      status = "primary",
                                      solidHeader = TRUE,
                                      collapsible = TRUE,
                                      htmlOutput("team")
                                  )
                                )),
                        tabItem ( tabName = "Bet",
                                  app_gameUI("game")

                        ),
                        tabItem ( tabName = "Information",
                                  fluidRow(
                                    app_analysisUI("analysis")
                                  ),
                                  fluidRow(
                                    column(width=10,
                                           box(title = "Web Scrapping Analysis",
                                               solidHeader = FALSE,
                                               selectInput(inputId = "choix_date",label = "Month",choices = month.abb),
                                               actionButton(inputId = "go2",label = "Go",icon = icon("GO"))
                                           ),
                                           htmlOutput("monde")
                                    )
                                  )
                        ),
                        tabItem ( tabName = "Map",
                                  fluidRow(
                                    app_MapUI("map"),
                                    htmlOutput("explication")

                                    )
                        )

                      )
                      )
                      )
