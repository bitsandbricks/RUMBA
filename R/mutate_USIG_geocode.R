#' mutate_USIG_geocode
#'
#' Geocoder basado en el servicio de USIG GCABA (http://usig.buenosaires.gob.ar/)
#' @export mutate_USIG_geocode
#' @param data Un dataframe con una columna que contiene direcciones dentro de los límites de la Región Urbana Metropolitana de Buenos Aires
#' @param address Nombre de la columna que contiene las direcciones
#' @examples
#'# Con un dataframe imput:
#'# lugar  valor                        direccion
#'#     A 225000 9 de Julio y Belgrano, Temperley
#'#     B 130500              Callao y Corrientes
#'#     C  34000                   Rivadavia 5100
#'
#'
#'datos <- data.frame(lugar = c("A", "B", "C"),
#'                    valor = c(225000, 130500, 34000),
#'                    direccion = c("9 de Julio y Belgrano, Temperley",
#'                                   "Callao y Corrientes",
#'                                   "Anchorena 1210, La Lucila"))
#'
#'
#'
#'
#'mutate_USIG_geocode(datos, "direccion")
#'
#'#    Resultado:
#'
#'# lugar  valor                        direccion                                                    address_normalised         lon         lat
#'#     A 225000 9 de Julio y Belgrano, Temperley Avenida 9 de Julio y Paso bajo nivel Manuel Belgrano, Lomas de Zamora -58.3964491 -34.7797373
#'#     B 130500              Callao y Corrientes                                     CALLAO AV. y CORRIENTES AV., CABA  -58.392293  -34.604434
#'#     C  34000                   Rivadavia 5100                                              RIVADAVIA AV. 5100, CABA  -58.437619  -34.618904


mutate_USIG_geocode <- function(data, address) {
    addresses <- data[[address]]
    results <- USIG_geocode(addresses)
    cbind(data, results)
}
