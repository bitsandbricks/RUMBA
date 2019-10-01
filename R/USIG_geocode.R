#' USIG_geocode
#'
#' Geocoder basado en el servicio de USIG GCABA (http://usig.buenosaires.gob.ar/)
#' @import httr
#' @importFrom utils URLencode
#' @export USIG_geocode
#' @param address Una dirección dentro de los límites de la Región Urbana Metropolitana de Buenos Aires
#' @examples
#' USIG_geocode("9 de julio y belgrano")
#'
#'#  Resultado:
#'#
#'#              address_normalised        lon        lat
#'# 9 DE JULIO AV. y BELGRANO, CABA -58.381226 -34.613090
#'#
#'#
#'# Si se trata de una dirección fuera de la Ciudad Autónoma de Buenos Aires, explicitar el municipio o partido:
#'
#' USIG_geocode("9 de julio y belgrano, temperley")
#'
#'#  Resultado:
#'#
#'#                                                    address_normalised       lon       lat
#'# Avenida 9 de Julio y Paso bajo nivel Manuel Belgrano, Lomas de Zamora -58.39645 -34.77974
#'#
#'
#'# Se pueden georeferenciar varias direcciones a la vez:
#'
#' USIG_geocode(c("9 de Julio y Belgrano, Temperley", "Callao y Corrientes", "Anchorena 1210, La Lucila"))
#'
#'#  Resultado:
#'#
#'#                                                    address_normalised               lon               lat
#'# Avenida 9 de Julio y Paso bajo nivel Manuel Belgrano, Lomas de Zamora       -58.3964491       -34.7797373
#'#                                     CALLAO AV. y CORRIENTES AV., CABA        -58.392293        -34.604434
# '#                                  Tomás Anchorena 1210, Vicente López -58.4935336530612 -34.5009281857143

USIG_geocode <- function(address) {

    make_call <- function(address) {

        #stopifnot(is.character(address))

        base_url <- "http://servicios.usig.buenosaires.gob.ar/normalizar/"

        make_address_query <- function(address) {
            query <- paste0(base_url,
                            "?direccion=",
                            address,
                            "&geocodificar=TRUE")
        }

        query <- URLencode(make_address_query(address))

        paste("Trying", query)

        results <- tryCatch(httr::GET(query),
                            error = function(error_message) {return(NULL)})



        if (!httr:::is.response(results)) {
            data.frame(address = address, address_normalised = NA,
                       lon = NA, lat = NA, stringsAsFactors = FALSE)
        } else {
            results <- httr::content(results)
            if (length(results$direccionesNormalizadas)) {
                x <- results$direccionesNormalizadas[[1]]$coordenadas$x
                y <- results$direccionesNormalizadas[[1]]$coordenadas$y
                address_normalised <- results$direccionesNormalizadas[[1]]$direccion
            } else {
                x <- NA
                y <- NA
                address_normalised <- NA
            }


            data.frame(address_normalised = ifelse(is.null(address_normalised), NA, address_normalised),
                       lon = ifelse(is.null(x), NA, as.numeric(x)),
                       lat = ifelse(is.null(y), NA, as.numeric(y)),
                       stringsAsFactors = FALSE)
        }
    }

    Reduce(rbind, lapply(address, make_call))

}
