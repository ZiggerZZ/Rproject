#' carto
#'
#' @param gareA selectionner from "dropdown menu" une gare du dataset "SNCF regularite"
#'
#' @return renvoie la carte de France avec les cotes par destination (moyenne du departement) à partir de la gare de départ sélectionnée. Si la gare n'existe pas alors le rendu par défaut est l'ensemble des cotes TGV de France.
#' @export
#' @import dplyr sf ggplot2
#'
#' @examples
#' carto("PARIS LYON")
#'

carto <- function(gareA){
  # ATTENTION gareA doit faire partie de la liste des gares
  department_cote <- cote_tbl %>%
    filter(gare_de_depart == gareA, country_arrivee == "France") %>%
    group_by(CODE_DEPT) %>%
    filter(!is.na(cote)) %>%
    summarise(cote = mean(cote))

  map_cote <- departement %>%
    left_join(department_cote, by = "CODE_DEPT")

  map <- ggplot(map_cote) +
    aes(fill = cote) +
    geom_sf() +
    coord_sf(crs = 2154) +
    scale_fill_gradient(low = "yellow", high = "purple")
  return(map)
}
