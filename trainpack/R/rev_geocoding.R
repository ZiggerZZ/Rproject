#' rev_geocoding
#'
#' @param lat latitude of a place
#' @param lon longitude of a place
#'
#' @return postcode of input address
#' @export
#' @importFrom jsonlite fromJSON
#'
#' @examples rev_geocoding(47.01671,-1.435332)


rev_geocoding <- function(lat, lon)
{
  d <- jsonlite::fromJSON(gsub("\\@lon\\@", lon, gsub("\\@lat\\@", lat,
                                                      'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=@lat@&lon=@lon@&zoom=18&addressdetails=1')))
  if(length(d) == 0) return(data.frame(postcode = 0))
  return(data.frame(postcode = as.numeric(d$address$postcode)))
}
