% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/USIG_geocode_barrios_vulnerables.R
\name{USIG_geocode_barrios_vulnerables}
\alias{USIG_geocode_barrios_vulnerables}
\title{USIG_geocode_barrios_vulnerables}
\usage{
USIG_geocode_barrios_vulnerables(address)
}
\arguments{
\item{address}{Una dirección con la manzana de un barrio vulnerable dentro de los límites de la Ciudad Autónoma de Buenos Aires}
}
\description{
Geocoder para manzanas en barrios vulnerables basado en el servicio de USIG GCABA (https://epok.buenosaires.gob.ar/deficithabitacional/)
}
\examples{
USIG_geocode_barrios_vulnerables("Villa 31, manzana 8")

#  Resultado:
#
#                               barrio_vuln        lon        lat
# Barrio Padre Carlos Mugica (Villa 31 bis) -58.37897   -34.58448
#
#
# 
#

# Se pueden georeferenciar varias direcciones a la vez:

USIG_geocode_barrios_vulnerables(c("Villa 31, manzana 2", "Rodrigo Bueno, manzana 2", "Villa 1-11-14, manzana 5"))

#  Resultado:
#
#                                                     barrio_vulnerable               lon               lat
#                             Barrio Padre Carlos Mugica (Villa 31 bis)         -58.37897         -34.58448
#                                            Asentamiento Rodrigo Bueno         -58.35382         -34.61905
}
