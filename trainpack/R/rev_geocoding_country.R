#' rev_geocoding_country
#'
#' @param lat 
#' @param lon 
#'
#' @return country (char)
#' @export
#' @import jsonlite
#' 
#' @examples
#' rev_geocoding_country( 47.01671,-1.435332)
#' 
 
rev_geocoding_country <- function(lat, lon)
{
  d <- jsonlite::fromJSON(gsub("\\@lon\\@", lon, gsub("\\@lat\\@", lat,
                                                      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=@lat@&lon=@lon@&zoom=18&addressdetails=1')))
  if(length(d) == 0) return(data.frame( postcode = 0))
  return(country = as.character(d$address$country))
}