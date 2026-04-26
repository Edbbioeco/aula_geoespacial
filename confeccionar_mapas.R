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

## Shapefile dos biomas ----

### Importar ----

biomas <- sf::st_read("biomas.shp")

### Visualizar ----

biomas

ggplot() +
  geom_sf(data = biomas,
          aes(color = name_biome, fill = name_biome)) +
  geom_sf(data = br, color = "black", fill = "transparent")

## Shapefile de Recife ----

### Importar ----

rec <- sf::st_read("recife.shp")

### Visualizar ----

rec

ggplot() +
  geom_sf(data = rec, color = "black")

## Imagem de satélite de Recife ----

### Importar ----

rec_sat <- terra::rast("recife_img_sat.tif")

### Visualizar ----

rec_sat

ggplot() +
  tidyterra::geom_spatraster_rgb(data = rec_sat) +
  geom_sf(data = rec, color = "red", fill = "transparent", linewidth = 1) +
  coord_sf(expand = FALSE)

# Mapa 1 ----

## Descrição ----

# mapa dos biomas que ocorrem no Nordeste
