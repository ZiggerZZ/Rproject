#' fonction_cote function
#'
#' @param gareA
#' @param gareB
#' @param mois
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
  cote <- SNCF_regularite %>%
    filter(`Gare de départ` == gareA, `Gare d'arrivée` == gareB, `Mois` == mois) %>% 
    mutate(`Proportion de trains en retard` = (`Nombre de trains annulés` + `Nombre trains en retard > 15min`)/`Nombre de circulations prévues`) %>% 
    summarise(`Cote` = 1/mean(`Proportion de trains en retard`))
  return(as.numeric(cote))
}
