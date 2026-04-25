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
