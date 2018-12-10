#' Proportion of Delay times
#'
#' @param gareD the name of the departure railway station.
#' Must be one of the stations in the dataframe \code{SNCF_regularite}.
#' @param gareA the name of the arrival railway station.
#' Must be one of the stations in the dataframe \code{SNCF_regularite}.
#' @param mois the month witch will be considered in the function
#' @import dplyr
#'
#' @return it will return a dataframe with different types of delay times as names of the column and the proportion of each type in the specific month, between two selected stations
#'
#' @export
#'
#' @examples delay_propr("PARIS MONTPARNASSE", "NANTES", 12)
delay_propr <- function(gareD,gareA,mois){
  SNCF_regularite_modif <- trainpack::SNCF_regularite %>%
    select(annee,mois,gare_de_depart,nombre_de_trains_annules,nombre_de_circulations_prevues,
           nombre_de_trains_en_retard_a_l_arrivee,gare_d_arrivee,nombre_trains_en_retard_15min,
           nombre_trains_en_retard_30min,nombre_trains_en_retard_60min) %>%
    group_by(gare_d_arrivee,gare_de_depart,mois) %>%
    summarise(proportion_trains_en_retard_15min = sum(nombre_trains_en_retard_15min)/(sum(nombre_de_trains_annules)+sum(nombre_trains_en_retard_60min)+sum(nombre_trains_en_retard_30min)+sum(nombre_trains_en_retard_15min)),
              proportion_trains_en_retard_30min = sum(nombre_trains_en_retard_30min)/(sum(nombre_de_trains_annules)+sum(nombre_trains_en_retard_60min)+sum(nombre_trains_en_retard_30min)+sum(nombre_trains_en_retard_15min)),
              proportion_trains_en_retard_60min = sum(nombre_trains_en_retard_60min)/(sum(nombre_de_trains_annules)+sum(nombre_trains_en_retard_60min)+sum(nombre_trains_en_retard_30min)+sum(nombre_trains_en_retard_15min)),
              proportion_trains_annules = sum(nombre_de_trains_annules)/(sum(nombre_de_trains_annules)+sum(nombre_trains_en_retard_60min)+sum(nombre_trains_en_retard_30min)+sum(nombre_trains_en_retard_15min)))

  res <- SNCF_regularite_modif %>% filter(gare_d_arrivee == gareA & gare_de_depart == gareD & mois == mois)

  return((res[,4:7]))
}
