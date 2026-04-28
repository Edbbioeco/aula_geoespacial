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

registros <- occ$data |>
  dplyr::mutate(decimalLatitude = decimalLatitude |>
                  sp::dd2dms(NS = TRUE) |>
                  as.character() |>
                  stringr::str_replace("d", "°"),
                decimalLongitude = decimalLongitude |>
                  sp::dd2dms(NS = FALSE) |>
                  as.character() |>
                  stringr::str_replace("d", "°"))

registros

## Exportar os registros ----

registros |> writexl::write_xlsx("coordenadas_registros.xlsx")
