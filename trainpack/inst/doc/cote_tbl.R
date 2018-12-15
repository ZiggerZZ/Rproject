## ---- eval = FALSE-------------------------------------------------------
#  
#  library(trainpack)
#  library(dplyr)
#  
#  # use data from package
#  SNCF_regularite <- trainpack::SNCF_regularite
#  

## ---- eval = FALSE-------------------------------------------------------
#  
#  SNCF_regularite <- SNCF_regularite %>%
#    rowwise %>%
#    mutate(gare_de_depart = gsub(" TGV","", gare_de_depart),
#           gare_d_arrivee = gsub(" TGV","", gare_d_arrivee)) %>%
#    ungroup()
#  

## ---- eval = FALSE-------------------------------------------------------
#  
#  sncf_lon_lat <- SNCF_regularite %>%
#    group_by(gare_de_depart, gare_d_arrivee) %>%
#    summarise() %>%
#    mutate( lon_depart = do.call(rbind, lapply(gare_de_depart,FUN = geocoding))$lon,
#            lat_depart = do.call(rbind, lapply(gare_de_depart,FUN = geocoding))$lat,
#            lon_arrivee = do.call(rbind, lapply(gare_d_arrivee,FUN = geocoding))$lon,
#            lat_arrivee = do.call(rbind, lapply(gare_d_arrivee,FUN = geocoding))$lat
#            )
#  
#  # Francfort did not work well so we'll change it manually. In the future we would need to implement this straight in the geocoding function.
#  sncf_lon_lat[sncf_lon_lat$gare_de_depart=="FRANCFORT",] <- sncf_lon_lat %>%
#    filter(gare_de_depart == "FRANCFORT") %>%
#    mutate(lon_depart = geocoding("gare de FRANCFORT")$lon, lat_depart = geocoding("gare de FRANCFORT")$lat)
#  

## ---- eval = FALSE-------------------------------------------------------
#  
#  sncf_lon_lat_postcode <- sncf_lon_lat %>%
#    rowwise() %>%
#    mutate(postcode_depart = as.character(mapply(rev_geocoding, lat = lat_depart, lon = lon_depart)),
#           postcode_arrivee = as.character(mapply(rev_geocoding, lat= lat_arrivee, lon = lon_arrivee))) %>%
#    mutate(country_depart = mapply(rev_geocoding_country, lat = lat_depart, lon = lon_depart),
#           country_arrivee = mapply(rev_geocoding_country, lat = lat_arrivee, lon = lon_arrivee))
#  

## ---- eval = FALSE-------------------------------------------------------
#  
#  sncf_lon_lat_postcode <- sncf_lon_lat_postcode %>%
#    filter(country_depart=="France") %>%
#    mutate(CODE_DEPT_depart = substr(postcode_depart,1,2),
#           CODE_DEPT = substr(postcode_arrivee,1,2))
#  

## ------------------------------------------------------------------------

#cote_tbl <- sncf_lon_lat_postcode %>% mutate(cote = mapply(fonction_cote, gareA = gare_de_depart, gareB = gare_d_arrivee, month = 12)) 


## ------------------------------------------------------------------------

# convert to df
#cote_tbl <- as.data.frame(cote_tbl, stringsAsFactors = FALSE)

#cote_tbl <- write.csv(cote_tbl, file = "cote_tbl.csv")


