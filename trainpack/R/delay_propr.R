#' Proportion of Delay times
#'
#' @param gareD - The name of the depurture Stations.
#'  it must be one of the station which exist in the database "SNCF_regularite"
#' @param gareA - The name of the arrival Stations.
#'  it must be one of the station which exist in the database "SNCF_regularite"
#' @param mois - the month witch will be consider in the function
#' @import dplyr
#'
#' @return it will return a dataframe with different types of delay times as names of the column and the proportion of each type in the specific month, between two selected stations
#'
#' @export
#'
#' @examples delay_propr("PARIS MONTPARNASSE", "NANTES", 12)
delay_propr <- function(gareD,gareA,mois){
  SNCF_regularite_modif <- SNCF_regularite %>%
    select(Année,Mois,`Gare de départ`,`Nombre de trains annulés`,`Nombre de circulations prévues`,`Nombre de trains en retard à l'arrivée`,`Gare d'arrivée`,`Nombre trains en retard > 15min`,`Nombre trains en retard > 30min`,`Nombre trains en retard > 60min`) %>%
    mutate(`Gare d'arrivée` = as.character(`Gare d'arrivée`),
           `Gare de départ` = as.character(`Gare de départ`),
           Mois = as.integer(Mois)) %>%
    mutate_if(is.factor, funs(as.numeric(levels(.)[.]))) %>%
    group_by(`Gare d'arrivée`,`Gare de départ`,Mois) %>%
    summarise(`Proportion trains en retard > 15min` = sum(`Nombre trains en retard > 15min`)/(sum(`Nombre de trains annulés`)+sum(`Nombre trains en retard > 60min`)+sum(`Nombre trains en retard > 30min`)+sum(`Nombre trains en retard > 15min`)),
              `Proportion trains en retard > 30min` = sum(`Nombre trains en retard > 30min`)/(sum(`Nombre de trains annulés`)+sum(`Nombre trains en retard > 60min`)+sum(`Nombre trains en retard > 30min`)+sum(`Nombre trains en retard > 15min`)),
              `Proportion trains en retard > 60min` = sum(`Nombre trains en retard > 60min`)/(sum(`Nombre de trains annulés`)+sum(`Nombre trains en retard > 60min`)+sum(`Nombre trains en retard > 30min`)+sum(`Nombre trains en retard > 15min`))
              ,`Proportion de trains annulés` = sum(`Nombre de trains annulés`)/(sum(`Nombre de trains annulés`)+sum(`Nombre trains en retard > 60min`)+sum(`Nombre trains en retard > 30min`)+sum(`Nombre trains en retard > 15min`)))

  res <- SNCF_regularite_modif %>%
    filter( `Gare d'arrivée`== gareA & `Gare de départ` == gareD & Mois == mois)

  return((res[,4:7]))
}
