# Pacotes ----

library(sf)

library(tidyverse)

library(maptiles)

library(tidyterra)

library(terra)

# Dados ----

## Importar ----

rec <- sf::st_read("recife.shp")

## Visualizar ----

rec

ggplot() +
  geom_sf(data = rec, color = "black")

# Imagem de satélite ----

## Baixar ----

rec_sat <- rec |>
  maptiles::get_tiles(provider = "Esri.WorldImagery",
                      zoom = 14)

## Visualizar ----

rec_sat

ggplot() +
  tidyterra::geom_spatraster_rgb(data = rec_sat) +
  geom_sf(data = rec, color = "red", fill = "transparent", linewidth = 1) +
  coord_sf(expand = FALSE)
