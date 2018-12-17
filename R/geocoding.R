#' Geocoding
#'
#' @param address is the address of the railway staytion. There is no special formatting, but the preferred one is: "gare de ..."
#'
#' @return data frame with latitude and longitude of said "google map" request
#' @export
#'
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' geocoding("nantes, gare")
#' geocoding("gare de nantes")$lon
#' geocoding("gare, nantes")$lat


geocoding <- function(address = NULL)
{
  if(suppressWarnings(is.null(address)))
    return(data.frame())
  tryCatch(
    d <- jsonlite::fromJSON(
      gsub('\\@addr\\@', gsub('\\s+', '\\%20', address),
           'http://nominatim.openstreetmap.org/search/@addr@?format=json&addressdetails=0&limit=1')
    ), error = function(c) return(data.frame(lon = 0, lat = 0))
  )
  if(length(d) == 0) return(data.frame(lon = 0, lat = 0))
  return(data.frame(lon = as.numeric(d$lon), lat = as.numeric(d$lat)))
}
