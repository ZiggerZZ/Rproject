% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/carto.R
\name{carto}
\alias{carto}
\title{carto}
\usage{
carto(gareA)
}
\arguments{
\item{gareA}{selectionner from "dropdown menu" une gare du dataset "SNCF regularite"}
}
\value{
renvoie la carte de France avec les cotes par destination (moyenne du departement) à partir de la gare de départ sélectionnée. Si la gare n'existe pas alors le rendu par défaut est l'ensemble des cotes TGV de France.
}
\description{
carto
}
\examples{
carto("PARIS LYON")

}
