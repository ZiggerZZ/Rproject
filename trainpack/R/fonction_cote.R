#' fonction_cote function
#'
#' @param gareA the name of the departure railway station.
#' Must be one of the stations in the dataframe \code{SNCF_regularite}.
#' @param gareB the name of the arrival railway station.
#' Must be one of the stations in the dataframe \code{SNCF_regularite}.
#' @param mois month when the train goes from (\code{gareA} to \code{gareB})
#'
#' @import dplyr
#'
#' @return odd of the train to be late
#' @export
#'
#' @examples fonction_cote("PARIS MONTPARNASSE", "NANTES", 12)
#'
#'

fonction_cote <- function(gareA, gareB, mois){
  cote <- trainpack::SNCF_regularite %>%
    filter(gare_de_depart == gareA, gare_d_arrivee == gareB, mois == mois) %>%
    mutate(proportion_de_trains_en_retard = (nombre_de_trains_annules + retard_moyen_trains_en_retard_15min)/nombre_de_circulations_prevues) %>%
    summarise(cote = 1/mean(proportion_de_trains_en_retard))
  return(as.numeric(cote))
}
