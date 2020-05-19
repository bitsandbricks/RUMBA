#' USIG_geocode_barrios_vulnerables
#'
#' Geocoder para manzanas en barrios vulnerables basado en el servicio de USIG GCABA (https://epok.buenosaires.gob.ar/deficithabitacional/)
#' @import tidyverse
#' @import raster
#' @import RCurl
#' @import rjson
#' @import httr
#' @importFrom utils URLencode
#' @export USIG_geocode
#' @param address Una dirección con la manzana de un barrio vulnerable dentro de los límites de la Ciudad Autónoma de Buenos Aires
#' @examples
#' USIG_geocode_barrios_vuln("Villa 31, manzana 8")
#'
#'#  Resultado:
#'#
#'#              barrio_vuln        lon        lat
#'# Barrio 15 (Ciudad Oculta) -58.49024  -34.66918
#'#
#'#
#'# 
#'#
#'
#'# Se pueden georeferenciar varias direcciones a la vez:
#'
#' USIG_geocode(c("Villa 31, manzana 2", "Rodrigo Bueno, manzana 2", "Villa 1-11-14, manzana 5"))
#'
#'#  Resultado:
#'#
#'#                                                     barrio_vulnerable               lon               lat
#'#                             Barrio Padre Carlos Mugica (Villa 31 bis)         -58.37897         -34.58448
#'#                                            Asentamiento Rodrigo Bueno         -58.35382         -34.61905
# '#                                Barrio Padre Ricciardelli (ex 1-11-14)        -58.43477         -34.64977


library(tidyverse)
library(RCurl)
library(rjson)

USIG_geocode_barrios_vulnerables(c("Villa 31, manzana 2", "Rodrigo Bueno, manzana 2", "Villa 1-11-14, manzana 5"))

USIG_geocode_barrios_vulnerables("Villa 15, manzana 8")

USIG_geocode_barrios_vulnerables <- function(address) {
  
  make_call <- function(address) {
    
    #stopifnot(is.character(address))
    
    base_url <- "https://epok.buenosaires.gob.ar/deficithabitacional/buscarManzana/"
    
    make_address_query <- function(address) {
      query <- paste0(base_url,
                      "?ubicacion=",
                      address)
    }
    
    query <- URLencode(make_address_query(address))
    
    paste("Trying", query)
    
    results <- tryCatch(fromJSON(getURL(query)),
                        error = function(error_message) {return(NULL)})
    
    
    
    if (httr:::is.response(results)) {
      data.frame(address = address, barrio_vulnerable = NA,
                 lon = NA, lat = NA, stringsAsFactors = FALSE)
    } else {
      results <- results
      if (length(results$instancias)) {
        x <- as.numeric(gsub(".*?([-]*[0-9]+[.][0-9]+).*", "\\1", results$instancias[[1]]$ubicacion$centroide))
        y <- as.numeric(gsub(".* ([-]*[0-9]+[.][0-9]+).*", "\\1", results$instancias[[1]]$ubicacion$centroide))
        barrio_vulnerable <- results$instancias[[1]]$contenido[[2]]$valor
      } else {
        x <- NA
        y <- NA
        barrio_vulnerable <- NA
      }
      
      
      data.frame(direccion = address,
                 barrio_vulnerable = ifelse(is.null(barrio_vulnerable), NA, barrio_vulnerable),
                 lon = ifelse(is.null(x), NA, as.numeric(x)),
                 lat = ifelse(is.null(y), NA, as.numeric(y)),
                 stringsAsFactors = FALSE)
    }
  }
  
  Reduce(rbind, lapply(address, make_call))
  
}

