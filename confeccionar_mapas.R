# Pacotes ----

library(sf)

library(tidyverse)

library(terra)

library(tidyterra)

library(ggspatial)

library(ggview)

library(ggmagnify)

library(patchwork)

# Dados ----

## Shapefile do Brasil ----

### Importar ----

br <- sf::st_read("br.shp")

### Visualizar ----

br

ggplot() +
  geom_sf(data = br, color = "black")

## Shapefile das regiões ----

### Importar ----

regioes <- sf::st_read("regioes.shp")

### Visualizar ----

regioes

ggplot() +
  geom_sf(data = regioes,
          aes(fill = nam_rgn),
          color = "black") +
  geom_sf(data = br, color = "black", fill = "transparent")
