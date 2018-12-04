library(readr)
library(dplyr)

SNCF_regularite <- read_delim("data-raw/regularite-mensuelle-tgv-aqst.csv", delim = ";", locale = locale(decimal_mark = ".")) #grouping_mark = ","
SNCF_regularite <- SNCF_regularite %>% mutate_at(vars(`Retard pour causes externes`,`Retard à cause infrastructure ferroviaire`,
                                                      `Retard à cause gestion trafic`, `Retard à cause matériel roulant`,
                                                      `Retard à cause gestion en gare et réutilisation de matériel`,
                                                      `Retard à cause prise en compte voyageurs`), function(x) x/100)
usethis::use_data(SNCF_regularite, overwrite = TRUE, internal = TRUE)
