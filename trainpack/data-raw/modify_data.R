library(readr)
SNCF_regularite <- read_csv2("data-raw/regularite-mensuelle-tgv-aqst.csv") #normally there shouldn't be parent directory data-raw/
usethis::use_data(SNCF_regularite, overwrite = TRUE)
