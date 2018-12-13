#' Cote par ligne avec numero de département
#'
#' Un tableau qui rassemble les différentes cotes ainsi que les numéros de départements associés aux gares de départ et d'arrivée
#'
#' @format A data frame with 123 rows and 14 variables:
#' \describe{
#'   \item{gare_de_depart}{departure trainstation}
#'   \item{gare_d_arrivee}{arrival trainstation}
#'   \item{lon_depart}{longitude of departure}
#'   \item{lat_depart}{latitude of departure}
#'   \item{lon_arrivee}{longitude of arrival}
#'   \item{lat_arrivee}{latitude of arrival}
#'   \item{postcode_depart}{postcode}
#'   \item{postcode_arrivee}{postcode arrival}
#'   \item{country_depart}{country of departure}
#'   \item{country_arrivee}{country of arrival}
#'   \item{CODE_DEPT_depart}{department code departure}
#'   \item{CODE_DEPT_arrivee}{department code arrival}
#'   \item{CODE_DEPT}{department code}
#'   \item{cote}{cote of train line}
#'   }
#' @source {google maps api + scnf_regularite}
"cote_tbl"
