#.rs.api.documentSaveAll() # closes and saves all open files
suppressWarnings(lapply(paste('package:', names(sessionInfo()$otherPkgs), sep = ""), detach, character.only = TRUE, unload = TRUE))# detach all  packages
rm(list = ls(all.names = TRUE))# clean environment
devtools::document('.') # create NAMESPACE and man
devtools::load_all('.') # load package
options(app.prod = FALSE) # TRUE = production mode, FALSE = development mode
trainpack::run_app('inst/app') # run the main app
