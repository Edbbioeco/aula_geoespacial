# Pacotes ---

library(rgbif)

library(writexl)

# Coordenadas ----

## TaxonKey ----

rgbif::name_backbone("Rhinella diptycha")

## Baixar coordenadas ----

occ <- rgbif::occ_search(scientificName = "Rhinella diptycha",
                         country = "BR",
                         hasCoordinate = TRUE,
                         limit = 50000)

## Data frame de registros -----

registros <- occ$data

registros
