# setup -------------------------------------------------------------------
library(tidyverse)
library(labelled)

# data loading ------------------------------------------------------------
set.seed(42)
data.raw <- read_csv("dataset/eleitos_2018.csv") %>%
  janitor::clean_names()

# data cleaning -----------------------------------------------------------

data.raw <- data.raw %>%
  #   filter() %>%
  select(
    -eleito,
  ) %>%
  # dropar variáveis com NA que não podem ser usadas na clusterização
  drop_na(num_votos)

# data wrangling ----------------------------------------------------------

data.raw <- data.raw %>%
  mutate(
    id = as.character(id),
    primeira = factor(primeira, labels = c("Primeiro mandato", "Reeleito")),
    sexo = factor(sexo, labels = c("Masculino", "Feminino")),
    evangelico = factor(evangelico, labels = c("Outros", "Evangélico")),
    igreja = fct_rev(fct_infreq(igreja)),
    total_receita = total_receita/1000000,
    num_votos = num_votos/1000000,
    filiados = filiados/1000000,
    receita_agp = receita_agp/1000000,
    receita_agr = receita_agr/1000000,
    receita_com = receita_com/1000000,
    receita_fin = receita_fin/1000000,
    receita_inf = receita_inf/1000000,
    receita_ind = receita_ind/1000000,
    receita_pf = receita_pf/1000000,
    receita_rp = receita_rp/1000000,
    receita_ser = receita_ser/1000000,
    # capilaridade = capilaridade*10,
  )

# labels ------------------------------------------------------------------

data.raw <- data.raw %>%
  set_variable_labels(
    partido = "Partido",
    uf = "UF",
    capilaridade = "Capilaridade",
    primeira = "Releição vs primeiro mandato",
    sexo = "Sexo",
    evangelico = "Evangélico",
    num_votos = "Votos (milhão)",
    decil_filiados = "Decil do núm. de filiados",
    decil_deputados = "Decil do núm. de deputados",
    total_receita = "Receita total (milhão R$)",
    posicao = "Índice de Power e Silveira-Rodrigues",
    igreja = "Nome da Igreja",
  )

# analytical dataset ------------------------------------------------------

analytical <- data.raw %>%
  # select analytic variables
  select(
    !starts_with(c("perc", "receita_")),
    -nome,
    -igreja,
    -categoria,
    -filiados,
    # -primeira,
  )

# mockup of analytical dataset for SAP and public SAR
analytical_mockup <- tibble( id = c( "1", "2", "3", "...", as.character(nrow(analytical)) ) ) %>%
  left_join(analytical %>% head(0), by = "id") %>%
  mutate_all(as.character) %>%
  replace(is.na(.), "")
