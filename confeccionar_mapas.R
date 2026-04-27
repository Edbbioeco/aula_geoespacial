# Pacotes ----

library(sf)

library(tidyverse)

library(terra)

library(tidyterra)

library(readxl)

library(ggspatial)

library(ggtext)

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

## Coordenadas de registros ----

### Importar ----

coord <- readxl::read_xlsx("coordenadas_registros.xlsx")

### Visualizar ----

coord

coord |> dplyr::glimpse()

### Transformar em shapefile ----

coord_sf <- coord |>
  dplyr::select(decimalLongitude, decimalLatitude) |>
  sf::st_as_sf(coords = c("decimalLongitude", "decimalLatitude"),
               crs = regioes |> sf::st_crs())

coord_sf

ggplot() +
  geom_sf(data = br, color = "black") +
  geom_sf(data = coord_sf)

# Mapa 1 ----

## Descrição ----

# mapa dos biomas que ocorrem no Nordeste e os seus registros de Rhinella diptyvha

## Recortar os biomas apaenas para o Nordeste -----

biomas_ne <- biomas |>
  sf::st_intersection(regioes |>
                        dplyr::filter(nam_rgn == "Nordeste"))

biomas_ne

ggplot() +
  geom_sf(data = biomas_ne, aes(fill = name_biome, color = name_biome))

## Recortar as coordenadas apenas para o Nordeste ----

coord_sf_ne <- coord_sf |>
  sf::st_intersection(regioes |>
                        dplyr::filter(nam_rgn == "Nordeste"))

coord_sf_ne

ggplot() +
  geom_sf(data = coord_sf_ne)

## Confeccionar mapa ----

mapa1 <- ggplot() +
  geom_sf(data = br) +
  geom_sf(data = biomas_ne, aes(fill = name_biome, color = name_biome)) +
  geom_sf(data = coord_sf_ne, color = "orangered", stroke = 1, alpha = 0.3) +
  geom_sf(data = br, color = "black", fill = "transparent", linewidth = 0.5) +
  scale_fill_manual(values = c("darkgreen",
                               "goldenrod",
                               "orange4",
                               "forestgreen",
                               "royalblue"),
                    name = "Bioma") +
  scale_color_manual(values = c("darkgreen",
                                "goldenrod",
                                "orange4",
                                "forestgreen",
                                "royalblue"),
                     name = "Bioma") +
  ggspatial::annotation_scale(text_cex = 2.5,
                              location = "br",
                              bar_cols = c("black", "gold"),
                              line_width = 2,
                              height = unit(0.5, "cm"),
                              width_hint = 0.1) +
  labs(title = "Registros de <i>Rhinella diptycha</i> ao longo dos Biomas do Nordeste") +
  theme_minimal() +
  theme(axis.text = element_text(color = "black", size = 17.5),
        legend.text = element_text(color = "black", size = 17.5),
        legend.title = element_text(color = "black", size = 17.5),
        plot.title = ggtext::element_markdown(color = "black", size = 17.5)) +
  ggview::canvas(height = 10, width = 12)

mapa1
