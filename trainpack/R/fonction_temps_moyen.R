#' fonction_temps_moyen function
#'
#' @param gareA
#' @param gareB
#'
#' @import dplyr
#'
#' @return average delay
#' @export
#'
#' @examples fonction_temps_moyen(gareA = "METZ", gareB = "PARIS EST")
fonction_temps_moyen <- function(gareA, gareB) {
  SNCF_regularite %>%
    filter(`Gare de départ` == gareA, `Gare d'arrivée` == gareB) %>%
    select(`Durée moyenne du trajet (min)`) %>%
    summarise(Mean_Time = mean(`Durée moyenne du trajet (min)`))
}
