library(readr)
library(dplyr)
library(sf)

SNCF_regularite <- read_delim("data-raw/regularite-mensuelle-tgv-aqst.csv", delim = ";", locale = locale(decimal_mark = ".")) #grouping_mark = ","
SNCF_regularite <- SNCF_regularite %>% mutate_at(vars(`Retard pour causes externes`,`Retard à cause infrastructure ferroviaire`,
                                                      `Retard à cause gestion trafic`, `Retard à cause matériel roulant`,
                                                      `Retard à cause gestion en gare et réutilisation de matériel`,
                                                      `Retard à cause prise en compte voyageurs`), function(x) x/100)
names(SNCF_regularite) <-
  c("annee", "mois", "sevice", "gare_de_depart", "gare_d_arrivee", "duree_moyenne_du_trajet",
    "nombre_de_circulations_prevues", "nombre_de_trains_annules", "commentaire_facultatif_annulations",
    "nombre_de_trains_en_retard_au_depart", "retard_moyen_des_trains_en_retard_au_depart",
    "retard_moyen_de_tous_les_trains_au_depart", "commentaire_facultatif_retards_au_depart",
    "nombre_de_trains_en_retard_a_l_arrivee", "retard_moyen_des_trains_en_retard_a_l_arrivee",
    "retard_moyen_de_tous_les_trains_a_l_arrivee", "commentaire_facultatif_retards_a_l_arrivee",
    "trains_en_retard_pour_causes_externes",
    "trains_en_retard_a_cause_infrastructure_ferroviaire",
    "trains_en_retard_a_cause_gestion_trafic",
    "trains_en_retard_a_cause_materiel_roulant",
    "trains_en_retard_a_cause_gestion_en_gare_et_reutilisation_de_materiel",
    "trains_en_retard_a_cause_prise_en_compte_voyageurs",
    "nombre_trains_en_retard_15min","retard_moyen_trains_en_retard_15min",
    "nombre_trains_en_retard_30min","nombre_trains_en_retard_60min",
    "periode","retard_pour_causes_externes","retard_a_cause_infrastructure_ferroviaire",
    "retard_a_cause_gestion_trafic","retard_a_cause_materiel_roulant",
    "retard_a_cause_gestion_en_gare_et_reutilisation_de_materiel","retard_a_cause_prise_en_compte_voyageurs")

lemonde_dates <- read_csv("data-raw/LeMondefr_Articles_dates.csv")
lemonde_dates <- lemonde_dates %>% select(-X1)
lemonde_dates <- lemonde_dates %>%
  mutate(month = case_when(
    month == "janvier" ~ 1,
    month == "février" ~ 2,
    month == "mars" ~ 3,
    month == "avril" ~ 4,
    month == "mai" ~ 5,
    month == "juin" ~ 6,
    month == "juillet" ~ 7,
    month == "août" ~ 8,
    month == "septembre" ~ 9,
    month == "octobre" ~ 10,
    month == "novembre" ~ 11,
    month == "décembre" ~ 12
  ))

departement <- st_read(dsn = 'data-raw/departements/',
                       layer = 'DEPARTEMENT',
                       quiet = TRUE) %>%
  mutate(CODE_DEPT = as.integer(as.character(CODE_DEPT))) %>%
  group_by(CODE_DEPT, NOM_REG) %>%
  summarise()

cote_tbl <- read_csv("data-raw/cote_tbl.csv")
cote_tbl <- cote_tbl %>% select(-X1)
cote_tbl["CODE_DEPT"] <- cote_tbl %>%
  select(CODE_DEPT) %>%
  rowwise() %>%
  mutate(CODE_DEPT = as.integer(CODE_DEPT))

usethis::use_data(SNCF_regularite, overwrite = TRUE, internal = FALSE)
usethis::use_data(lemonde_dates, overwrite = TRUE, internal = FALSE)
usethis::use_data(departement, overwrite = TRUE, internal = FALSE)
usethis::use_data(cote_tbl, overwrite = TRUE, internal = FALSE)
