# base de dados
nb

# cluster hierárquico
hc.c
# clusters k = 4
cutree(hc.c, k = 4)

# juntar os dados
identidades <- data.raw %>%
  select(id, nome, partido, sexo, uf) %>%
  inner_join(nb, by = "id")

# identificar os outliers
identidades %>%
  filter(cl4 == 4)

# top 5 número de votos
identidades %>%
  slice_max(num_votos, n = 5)

# top 5 receitas
identidades %>%
  slice_max(total_receita, n = 5)
