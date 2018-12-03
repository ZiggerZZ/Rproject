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
fonction_temps_moyen <- function(gareA, gareB){
  SNCF_regularite_modif <-
    SNCF_regularite %>%
    filter("Gare de départ"==gareA, "Gare d'arrivée"==gareB)

  SNCF_regularite_modif %>%
    select("Durée moyenne du trajet (min)") %>%
    mutate("Durée moyenne du trajet (min)" = as.numeric(as.character("Durée moyenne du trajet (min)"))) %>%
    summarise(Mean_Time = mean(as.numeric("Durée moyenne du trajet (min)")))
}
