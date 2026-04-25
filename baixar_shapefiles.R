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
  geom_sf(data = br, color = "black") +
  geom_sf(data = regioes, aes(color = name_region, fill = name_region), alpha = 0.3)

### Exportar ----

regioes |> sf::st_write("regioes.shp")
