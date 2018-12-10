#' fonction_raison function
#'
#' @param gareA 
#' @param gareB 
#' @param mois 
#'
#' @return a summary of the most probable reasons for a train to be late
#' @import dplyr
#' @export 
#'
#' @examples fonction_raison("PARIS MONTPARNASSE", "NANTES", 4)


fonction_raison <- function(gareA, gareB, mois){
  raison <- SNCF_regularite %>%
    filter(`Gare de départ` == gareA, `Gare d'arrivée` == gareB, Mois == mois) %>% 
    summarise(`cause externe` = mean(`% trains en retard pour causes externes (météo, obstacles, colis suspects, malveillance, mouvements sociaux, etc.)`),
              `infrastructure` = mean(`% trains en retard à cause infrastructure ferroviaire (maintenance, travaux)`),
              `gestion trafic` = mean(`% trains en retard à cause gestion trafic (circulation sur ligne ferroviaire, interactions réseaux)`),
              `materiel roulant` = mean(`% trains en retard à cause matériel roulant`),
              `gestion en gare` = mean(`% trains en retard à cause gestion en gare et réutilisation de matériel`),
              `prise en compte voyageur` = mean(`% trains en retard à cause prise en compte voyageurs (affluence, gestions PSH, correspondances)`))
  return(raison)
}
