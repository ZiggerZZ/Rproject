#' fonction_temps_moyen function
#'
#' @param gareA the name of the departure railway station.
#' Must be one of the stations in the dataframe \code{SNCF_regularite}.
#' @param gareB the name of the arrival railway station.
#' Must be one of the stations in the dataframe \code{SNCF_regularite}.
#'
#' @import dplyr
#'
#' @return average delay
#' @export
#'
#' @examples fonction_temps_moyen(gareA = "METZ", gareB = "PARIS EST")
fonction_temps_moyen <- function(gareA, gareB) {
  trainpack::SNCF_regularite %>%
    filter(gare_de_depart == gareA, gare_d_arrivee == gareB) %>%
    select(duree_moyenne_du_trajet) %>%
    summarise(Mean_Time = mean(duree_moyenne_du_trajet))
}
