# setup -------------------------------------------------------------------
# library(gt)
# library(gtsummary)
# library(moderndive)
# library(broom)
# library(broom.mixed)
library(dendextend)
library(ggdendro)
library(cluster)

km_ss <- function(data, k) {
  kmeans(data, centers = k)$tot.withinss
}

hc_sil <- function(hc, k) {
  s <- silhouette(cutree(hc, k = k), dist = nb.dist)
  mean(s[, 3])
}

# kmeans ------------------------------------------------------------------

nb <- analytical %>%
  select(evangelico, where(is.numeric))

kmax <- 10

nb$km2 <- kmeans(nb[, -1], 2)$cluster
nb$km4 <- kmeans(nb[, -1], 4)$cluster

# dataframe para elbow plot
elbow <- tibble(
  k = 1:kmax,
  withinss = map_dbl(1:kmax, km_ss, data = nb[, -1])
  )

# cluster hierárquico -----------------------------------------------------

nb.dist <- dist(nb[, -1])
hc.a <- hclust(nb.dist, method = "average")
hc.c <- hclust(nb.dist, method = "complete")
hc.m <- hclust(nb.dist, method = "single")

avg_sil_hc <- tibble(
  k = 2:kmax,
  avg_sil = map_dbl(2:kmax, hc_sil, hc = hc.m)
)

# sensibilidade - full dataset --------------------------------------------

nb.fd <- data.raw %>%
  select(evangelico, where(is.numeric), -starts_with("perc")) %>%
  mutate(posicao = posicao +1) # recentrar posicao entre 0 e 2

nb.fd$km2 <- kmeans(nb.fd[, -1], 2)$cluster
nb.fd$km4 <- kmeans(nb.fd[, -1], 4)$cluster

# dataframe para elbow plot
elbow.fd <- tibble(
  k = 1:kmax,
  withinss = map_dbl(1:kmax, km_ss, data = nb.fd[, -1])
  )

nb.dist.fd <- dist(nb.fd[, -1])
hc.m.fd <- hclust(nb.dist.fd, method = "single")
avg_sil_hc.fd <- tibble(
  k = 2:kmax,
  avg_sil = map_dbl(2:kmax, hc_sil, hc = hc.m.fd)
)

# diagnosticos ------------------------------------------------------------

km2_a <- analytical %>% select_if(is.numeric) %>% kmeans(centers = 2, nstart = 10)
km2_t <- data.raw   %>% select_if(is.numeric) %>% kmeans(centers = 2, nstart = 10)

# kmeans com 2 clusters
CrossTable(km2_a$cluster, analytical$evangelico, mcnemar = TRUE)
CrossTable(km2_t$cluster, data.raw$evangelico, mcnemar = TRUE)
