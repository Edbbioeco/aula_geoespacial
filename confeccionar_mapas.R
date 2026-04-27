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

## Shapefile das unidades de conservação ----

### Importar ----

uni_con <- sf::st_read("unidade_conservacao.shp")

### Visualizar ----

uni_con

ggplot() +
  geom_sf(data = br, color = "black") +
  geom_sf(data = uni_con, color = "forestgreen")

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

# Mapa 2 ----

## Descrição ----

# mapa de localização das unidades de conservação em Refice

## Recortar o shapefile das unidades de conservação apenas para Recife ----

uni_con_ne <- uni_con |>
  sf::st_intersection(rec)

uni_con_ne

ggplot() +
  geom_sf(data = rec) +
  geom_sf(data = uni_con_ne)

## Confeccionar mapa ----

### Mapa 2.1 ----

mapa2_1 <- ggplot(data = br) +
  geom_sf(aes(color = "Brasil",
              fill = "Brasil"),
          linewidth = 0.5) +
  geom_sf(data = br |>
            dplyr::filter(nam_stt == "Pernambuco"),
          aes(color = "Pernambuco",
              fill = "Pernambuco"),
          linewidth = 0.5) +
  geom_sf(data = rec,
          aes(color = "Recife",
              fill = "Recife"),
          linewidth = 0.75) +
  coord_sf(label_graticule = "NSW") +
  scale_fill_manual(values = c("Recife" = "transparent",
                               "Brasil" = "gray",
                               "Pernambuco" = "goldenrod")) +
  scale_color_manual(values = c("Recife" = "red",
                                "Brasil" = "black",
                                "Pernambuco" = "black")) +
  labs(fill = NULL,
       color = NULL) +
  ggmagnify::geom_magnify(from = c(-35.0167,
                                   -34.86058,
                                   -8.155123,
                                   -7.929206),
                          to = c(-35.0167 - 5,
                                 -34.86058 + 5,
                                 -32.5,
                                 -20),
                          shape = "rect",
                          recompute = TRUE,
                          shadow = TRUE,
                          linewidth = 0.8,
                          expand = FALSE) +
  theme_minimal() +
  theme(axis.text = element_text(color = "black", size = 17.5),
        legend.text = element_text(color = "black", size = 17.5),
        legend.title = element_text(color = "black", size = 17.5),
        legend.position = "bottom") +
  ggview::canvas(height = 10, width = 12)

mapa2_1

### Mapa 2,2 -----

mapa2_2 <- ggplot() +
  tidyterra::geom_spatraster_rgb(data = rec_sat) +
  geom_sf(data = rec,
          color = "red",
          fill = "transparent",
          linewidth = 0.75) +
  geom_sf(data = uni_con_ne,
          aes(color = "Unidades de Conservação",
              fill = "Unidades de Conservação"),
          linewidth = 0.75,
          alpha = 0.3) +
  coord_sf(label_graticule = "NSE",
           expand = FALSE) +
  scale_fill_manual(values = c("Unidades de Conservação" = "goldenrod")) +
  scale_color_manual(values = c("Unidades de Conservação" = "goldenrod")) +
  labs(fill = NULL,
       colour = NULL) +
  ggspatial::annotation_scale(text_cex = 2.5,
                              text_col = "gold",
                              location = "br",
                              bar_cols = c("black", "gold"),
                              line_width = 2,
                              height = unit(0.5, "cm"),
                              width_hint = 0.25) +
  scale_x_continuous(breaks = seq(-35, -34.85, 0.05)) +
  theme_minimal() +
  theme(axis.text = element_text(color = "black", size = 17.5),
        legend.text = element_text(color = "black", size = 17.5),
        legend.title = element_text(color = "black", size = 17.5),
        legend.position = "bottom") +
  ggview::canvas(height = 10, width = 12)

mapa2_2

### Unir os mapas ----

(mapa2_1 + mapa2_2) +
  patchwork::plot_layout(guides = "collect") &
  theme(legend.position = "bottom") &
  ggview::canvas(height = 10, width = 12)
