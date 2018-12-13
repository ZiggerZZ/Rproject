#' fonction_raison function
#'
#' @param gareA the name of the departure railway station.
#' Must be one of the stations in the dataframe \code{SNCF_regularite}.
#' @param gareB the name of the arrival railway station.
#' Must be one of the stations in the dataframe \code{SNCF_regularite}.
#' @param mois month when the train goes from \code{gareA} to \code{gareB}.
#'
#' @return a summary of the most probable reasons for a train to be late
#' @import dplyr
#' @export
#'
#' @examples fonction_raison("PARIS MONTPARNASSE", "NANTES", 4)


fonction_raison <- function(gareA, gareB, month){
  trainpack::SNCF_regularite %>%
    filter(gare_de_depart == gareA, gare_d_arrivee == gareB, mois == month) %>%
    summarise(cause_externe = mean(retard_pour_causes_externes),
              infrastructure = mean(retard_a_cause_infrastructure_ferroviaire),
              gestion_trafic = mean(retard_a_cause_gestion_trafic),
              materiel_roulant = mean(retard_a_cause_materiel_roulant),
              gestion_en_gare = mean(retard_a_cause_gestion_en_gare_et_reutilisation_de_materiel),
              prise_en_compte_voyageur = mean(retard_a_cause_prise_en_compte_voyageurs))
}
