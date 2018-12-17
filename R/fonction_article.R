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
  trainpack::lemonde_dates %>%
    filter(month == mois) %>%
    summarise(nb_of_article = mean(n)) %>%
    as.numeric()
}
