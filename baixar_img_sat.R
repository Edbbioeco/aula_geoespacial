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
