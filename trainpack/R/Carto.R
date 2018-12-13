#' Carto
#'
#' @param gareA selectionner from "dropdown menu" une gare du dataset "SNCF regularite"
#'
#' @return renvoie la carte de France avec les cotes par destination (moyenne du departement) à partir de la gare de départ sélectionnée. Si la gare n'existe pas alors le rendu par défaut est l'ensemble des cotes TGV de France.
#' @export
#' @import dyplr, sf
#'
#' @examples
#' carto("PARIS LYON")
#'

carto <- function(gareA){
  # ATTENTION gareA doit faire partie de la liste des gares
  department_cote <- departement %>%
    left_join(cote_tbl, by = "CODE_DEPT") %>%
    filter(gare_de_depart == gareA) %>%
    group_by(CODE_DEPT) %>%
    filter(!is.na(cote)) %>%
    summarise(cote = mean(cote))

  map_cote <- departement %>%
    st_join(department_cote, left = TRUE)

  department_cote_error <- departement %>%
    left_join(cote_tbl, by = "CODE_DEPT") %>%
    #filter(gare_de_depart == gareA) %>%
    group_by(CODE_DEPT) %>%
    filter(!is.na(cote)) %>%
    summarise(cote = mean(cote))

  map_cote_error <- departement %>%
    st_join(department_cote_error, left = TRUE)

  map_error <- ggplot(map_cote_error) +
    aes(fill = cote) +
    geom_sf() +
    coord_sf(crs = 2154) +
    scale_fill_gradient(low = "yellow", high = "purple")
  return(map_error)

  tryCatch(
    map <- ggplot(map_cote) +
      aes(fill = cote) +
      geom_sf() +
      coord_sf(crs = 2154) +
      scale_fill_gradient(low = "yellow", high = "purple"),

    error = function(c) return(map_error)
  )
  return(map)
}
