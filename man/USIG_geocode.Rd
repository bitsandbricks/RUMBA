% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/USIG_geocode.R
\name{USIG_geocode}
\alias{USIG_geocode}
\title{USIG_geocode}
\usage{
USIG_geocode(address)
}
\arguments{
\item{address}{Una dirección dentro de los límites de la Región Urbana Metropolitana de Buenos Aires}
}
\description{
Geocoder basado en el servicio de USIG GCABA (http://usig.buenosaires.gob.ar/)
}
\examples{
USIG_geocode("9 de julio y belgrano")

#  Resultado:
#
#              address_normalised        lon        lat
# 9 DE JULIO AV. y BELGRANO, CABA -58.381226 -34.613090
#
#
# Si se trata de una dirección fuera de la Ciudad Autónoma de Buenos Aires, explicitar el municipio o partido:

USIG_geocode("9 de julio y belgrano, temperley")

#  Resultado:
#
#                                                    address_normalised       lon       lat
# Avenida 9 de Julio y Paso bajo nivel Manuel Belgrano, Lomas de Zamora -58.39645 -34.77974
#

# Se pueden georeferenciar varias direcciones a la vez:

USIG_geocode(c("9 de Julio y Belgrano, Temperley", "Callao y Corrientes", "Anchorena 1210, La Lucila"))

#  Resultado:
#
#                                                    address_normalised               lon               lat
# Avenida 9 de Julio y Paso bajo nivel Manuel Belgrano, Lomas de Zamora       -58.3964491       -34.7797373
#                                     CALLAO AV. y CORRIENTES AV., CABA        -58.392293        -34.604434
}
