#' Average number of article per month
#'
#' @param mois the month witch will be considered in the function
#' @import dplyr
#'
#' @return it will return the value of the mean number of article published on LeMonde.fr for the given month 
#'
#' @export
#'
#' @examples fonction_article(12)


fonction_article <- function(mois){
  trainpack::lemonde_dates %>% mutate(month = case_when(
    month == "janvier" ~ 1,
    month == "février" ~ 2,
    month == "mars" ~ 3,
    month == "avril" ~ 4,
    month == "mai" ~ 5,
    month == "juin" ~ 6,
    month == "juillet" ~ 7,
    month == "août" ~ 8,
    month == "septembre" ~ 9,
    month == "octobre" ~ 10,
    month == "novembre" ~ 11, 
    month == "décembre" ~ 12
  )) %>%
    filter(month == mois) %>%
    summarise(nb_of_article = mean(n)) %>% 
    as.numeric()
  }
