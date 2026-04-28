# Pacotes ----

library(gert)

# Lista de arquivos áptos ----

gert::git_status() |>
  as.data.frame()

# Adicionar arquivos ----

gert::git_add(files = "confeccionar_mapas.R") |>
  as.data.frame()

# Commit ----

gert::git_commit(message = "Exportar os mapas")

# Push ----

gert::git_push(remote = "origin")

# Pull ----

gert::git_pull(remote = "origin")

# Reset ----

gert::git_reset_mixed(ref = "HEAD^1")

gert::git_reset_soft(ref = "HEAD^1")

# Remove ----

gert::git_add(files = "") |>
  as.data.frame

gert::git_commit(message = "")

gert::git_push(remote = "origin")

gert::git_pull(remote = "origin")
