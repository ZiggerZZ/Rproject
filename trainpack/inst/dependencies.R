# No Remotes ----
# Attachments ----
to_install <- c("dplyr", "DT", "ggplot2", "jsonlite", "magick", "sf", "shiny", "shinydashboard", "stats", "tidyr", "tidyverse")
  for (i in to_install) {
    message(paste("looking for ", i))
    if (!requireNamespace(i)) {
      message(paste("     installing", i))
      install.packages(i)
    }

  }
