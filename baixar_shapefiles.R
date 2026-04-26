# Instalar os pacotes ----

if(require(c("geobr", "tidyverse", "sf"))) {

  install.packages(c("geobr", "tidyverse", "sf"))
}

# Carregar os pacotes ----

library(geobr)

library(tidyverse)

library(sf)

# Shapefiles ----

## Brasil ----

### Importar ----

br <- geobr::read_state(year = 2019)

### Visualizar ----

br

ggplot() +
  geom_sf(data = br, color = "black")

### Exportar -----

br |> sf::st_write("br.shp")

## Regiões ----

### Importar ----

regioes <- geobr::read_region(year = 2019)

### Visualizar ----

regioes

ggplot() +
  geom_sf(data = regioes, aes(color = name_region, fill = name_region)) +
  geom_sf(data = br, color = "black", fill= "transparent")

### Exportar ----

regioes |> sf::st_write("regioes.shp")

## Biomas ----

### Importar ----

biomas <- geobr::read_biomes(year = 2019)

### Visualizar ----

biomas

ggplot() +
  geom_sf(data = biomas, aes(color = name_biome, fill = name_biome)) +
  geom_sf(data = br, color = "black", fill= "transparent")

### Exportar ----

biomas |> sf::st_write("biomas.shp")

## Shapefilede Recife ----

### Importar ----

recife <- geobr::read_municipality() |>
  dplyr::filter(name_muni == "Recife")

### Visualizar ----

recife

ggplot() +
  geom_sf(data = recife, color = "black")

### Exportar ----

recife |> sf::st_write("recife.shp")

### Shapefile das unidades de cpnservação ----

### Importar -----

u_c <- geobr::read_conservation_units() |>
  sf::st_make_valid()
