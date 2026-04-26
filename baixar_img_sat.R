# Pacotes ----

library(sf)

library(tidyverse)

library(maptiles)

library(tidyterra)

library(terra)

# Dados ----

## Importar ----

rec <- sf::st_read("recife.shp")
