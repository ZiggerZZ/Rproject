## ---- eval = FALSE-------------------------------------------------------
#  library(dplyr)
#  library(rvest)
#  library(purrr)
#  library(httr)
#  library(glue)
#  library(tidyr)

## ---- eval = FALSE-------------------------------------------------------
#  number_of_pages <- read_html("https://www.lemonde.fr/recherche/?keywords=gr%C3%A8ve+sncf&page_num=1&operator=or&exclude_keywords=&qt=recherche_texte_titre&author=&period=custom_date&start_day=01&start_month=01&start_year=2015&end_day=04&end_month=12&end_year=2018&sort=desc") %>%
#    html_nodes(".page") %>%
#    html_text() %>%
#    as.numeric() %>%
#    as.vector() %>%
#    max()

## ---- eval = FALSE-------------------------------------------------------
#  my_page <- function(num) {
#    url <- glue("https://www.lemonde.fr/recherche/?keywords=gr%C3%A8ve+sncf&page_num={num}&operator=or&exclude_keywords=&qt=recherche_texte_titre&author=&period=custom_date&start_day=01&start_month=01&start_year=2015&end_day=04&end_month=12&end_year=2018&sort=desc")
#    read_html(url)
#    }
#  
#  pages <- lapply(1:number_of_pages, my_page)

## ---- eval = FALSE-------------------------------------------------------
#  get_dates <- function(page){
#    page %>%
#      html_nodes("span.txt1.signature") %>%
#      html_text() %>%
#      as.data.frame(stringsAsFactors = FALSE) %>%
#      separate(".", into= c("Source", "Date"), sep = '[|]') %>%
#      separate("Date", into = c('space', 'day', 'month', 'year'), sep = " ") %>%
#      select("month", "year")
#  }
#  
#  dates <- lapply(pages, get_dates)
#  
#  alldates <- do.call(rbind, dates) %>%
#    group_by(month, year) %>%
#    count()
#  
#  alldates
#  

## ---- eval = FALSE-------------------------------------------------------
#  
#  write.csv(alldates, file = "LeMondefr_Articles_dates.csv")
#  

