#' mutate_USIG_geocode_barrios_vulnerables
#'
#' Geocoder basado en el servicio de USIG GCABA (http://usig.buenosaires.gob.ar/)
#' @export mutate_USIG_geocode_barrios_vulnerables
#' @param data Un dataframe con una columna que contiene una dirección con la manzana de un barrio vulnerable dentro de los límites de la Ciudad Autónoma de Buenos Aires
#' @param address Nombre de la columna que contiene las direcciones
#' @examples
#'# Con un dataframe imput:
#'# lugar  valor                        direccion
#'#     A 225000              Villa 31, manzana 2
#'#     B 130500         Rodrigo Bueno, manzana 2
#'#     C  34000         Villa 1-11-14, manzana 5
#'
#'
#'datos <- data.frame(lugar = c("A", "B", "C"),
#'                    valor = c(225000, 130500, 34000),
#'                    direccion = c("Villa 31, manzana 2",
#'                                   "Rodrigo Bueno, manzana 2",
#'                                   "Villa 1-11-14, manzana 5"))
#'
#'
#'
#'
#'mutate_USIG_geocode_barrios_vulnerables(datos, "direccion")
#'
#'#    Resultado:
#'
#'# lugar  valor                        direccion                             address_normalised           lon          lat
#'#     A 225000              Villa 31, manzana 2      Barrio Padre Carlos Mugica (Villa 31 bis)     -58.37897    -34.58448
#'#     B 130500         Rodrigo Bueno, manzana 2                     Asentamiento Rodrigo Bueno     -58.35382    -34.61905
#'#     C  34000         Villa 1-11-14, manzana 5         Barrio Padre Ricciardelli (ex 1-11-14)     -58.43477    -34.64977


mutate_USIG_geocode_barrios_vulnerables <- function(data, address) {
    addresses <- data[[address]]
    results <- USIG_geocode_barrios_vulnerables(addresses)
    cbind(data, results)
}
