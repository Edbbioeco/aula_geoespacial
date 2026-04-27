# Pacotes ---

library(rgbif)

library(writexl)

# Coordenadas ----

## TaxonKey ----

rgbif::name_backbone("Scinax x-signatus")

## Baixar coordenadas ----

occ <- rgbif::occ_search(scientificName = "Scinax x-signatus",
                         country = "BR",
                         hasCoordinate = TRUE,
                         limit = 50000)
