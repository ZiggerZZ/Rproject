#' Cote par ligne avec numero de département
#'
#' Un tableau qui rassemble les différentes cotes ainsi que les numéros de départements associés aux gares de départ et d'arrivée
#'
#' @format A data frame with 123 rows and 14 variables:
#' \describe{
#'   \item{gare_de_depart}{department code}
#'   \item{gare_d_arrivee}{region name}
#'   \item{lon_depart}{shape of the department France in crs 2154}
#'   \item{lat_depart}{region name}
#'   \item{lon_arrivee}{shape of the department France in crs 2154}
#'   \item{lat_arrivee}{region name}
#'   \item{postcode_depart}{shape of the department France in crs 2154}
#'   \item{postcode_arrivee}{region name}
#'   \item{country_depart}{shape of the department France in crs 2154}
#'   \item{country_arrivee}{region name}
#'   \item{CODE_DEPT_depart}{shape of the department France in crs 2154}
#'   \item{CODE_DEPT_arrivee}{region name}
#'   \item{CODE_DEPT}{shape of the department France in crs 2154}
#'   \item{cote}{region name}
#'   }
#' @source {google maps api + scnf_regularite}
"cote_tbl"
