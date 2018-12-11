#' Information about the SNCF trains starting from 2015.
#'
#' A dataset containing the statistics and other information about the delays of SNCF trains.
#'
#' @format A data frame with 5032 rows and 34 variables:
#' \describe{
#'   \item{annee}{Year}
#'   \item{mois}{Month}
#'   \item{sevice}{International or TGV}
#'   \item{gare_de_depart}{Departure railway station}
#'   \item{gare_d_arrivee}{Arrival railway station}
#'   \item{duree_moyenne_du_trajet}{Average duration of the journey}
#'   \item{nombre_de_circulations_prevues}{Planned number of circulations}
#'   \item{nombre_de_trains_annules}{Number of cancelled trains}
#'   \item{commentaire_facultatif_annulations}{Comment about cancellations}
#'   \item{nombre_de_trains_en_retard_au_depart}{Number of trains delayed at departure}
#'   \item{retard_moyen_des_trains_en_retard_au_depart}{Average delay of trains late at departure (min)}
#'   \item{retard_moyen_de_tous_les_trains_au_depart}{Average delay of all the trains at departure (min)}
#'   \item{commentaire_facultatif_retards_au_depart}{Comment about delays at departure}
#'   \item{nombre_de_trains_en_retard_a_l_arrivee}{Number of trains late at arrival}
#'   \item{retard_moyen_des_trains_en_retard_a_l_arrivee}{Average delay of trains late at arrival (min)}
#'   \item{retard_moyen_de_tous_les_trains_a_l_arrivee}{Average delay of all the trains late at arrival (min)}
#'   \item{commentaire_facultatif_retards_a_l_arrivee}{Comment about delays at arrival}
#'   TRANSLATE TO ENGLISH THE FOLLOWING DESCRIPTIONS
#'   \item{trains_en_retard_pour_causes_externes}{\% trains en retard pour causes externes (météo, obstacles, colis suspects, malveillance, mouvements sociaux, etc.)}
#'   \item{trains_en_retard_a_cause_infrastructure_ferroviaire}{\% trains en retard à cause infrastructure ferroviaire (maintenance, travaux)}
#'   \item{trains_en_retard_a_cause_gestion_trafic}{\% trains en retard à cause gestion trafic (circulation sur ligne ferroviaire, interactions réseaux)}
#'   \item{trains_en_retard_a_cause_materiel_roulant}{\% trains en retard à cause matériel roulant}
#'   \item{trains_en_retard_a_cause_gestion_en_gare_et_reutilisation_de_materiel}{\% trains en retard à cause gestion en gare et réutilisation de matériel}
#'   \item{trains_en_retard_a_cause_prise_en_compte_voyageurs}{\% trains en retard à cause prise en compte voyageurs (affluence, gestions PSH, correspondances)}
#'   \item{nombre_trains_en_retard_15min}{Nombre trains en retard > 15min (si liaison concurrencée par vol)}
#'   \item{retard_moyen_trains_en_retard_15min}{Retard moyen trains en retard > 15min (si liaison concurrencée par vol)}
#'   \item{nombre_trains_en_retard_30min}{Nombre trains en retard > 30min}
#'   \item{nombre_trains_en_retard_60min}{Nombre trains en retard > 60min}
#'   \item{periode}{Period (date)}
#'   \item{retard_pour_causes_externes}{Retard pour causes externes (météo, obstacles, colis suspects, malveillance, mouvements sociaux, etc.)}
#'   \item{retard_a_cause_infrastructure_ferroviaire}{Retard à cause infrastructure ferroviaire (maintenance, travaux)}
#'   \item{retard_a_cause_gestion_trafic}{Retard à cause gestion trafic (circulation sur ligne ferroviaire, interactions réseaux)}
#'   \item{retard_a_cause_materiel_roulant}{Retard à cause matériel roulant}
#'   \item{retard_a_cause_gestion_en_gare_et_reutilisation_de_materiel}{Retard à cause gestion en gare et réutilisation de matériel}
#'   \item{retard_a_cause_prise_en_compte_voyageurs}{Retard à cause prise en compte voyageurs (affluence, gestions PSH, correspondances)}
#' }
#' @source \url{https://data.sncf.com/explore/dataset/regularite-mensuelle-tgv-aqst/table/?sort=periode&fbclid=IwAR1iEGCOzJKKqUCVA-zJLW8-3w9zKi1R7LhYYd5BsBVlqvCCZvyafZlUqN4}
"SNCF_regularite"
