# setup -------------------------------------------------------------------
library(cluster)

km_ss <- function(data, k) {
  kmeans(data, centers = k)$tot.withinss
}

hc_sil <- function(hc, k, hc_dist) {
  s <- silhouette(cutree(hc, k = k), dist = hc_dist)
  mean(s[, 3])
}

# kmeans ------------------------------------------------------------------

nb <- analytical %>%
  select(id, evangelico, where(is.numeric))

kmax <- 10

# dataframe para elbow plot
elbow <- tibble(
  k = 1:kmax,
  withinss = map_dbl(1:kmax, km_ss, data = nb[, -c(1:2)])
  )

# cluster hierárquico -----------------------------------------------------

nb.dist <- dist(nb[, -c(1:2)])
# hc.a <- hclust(nb.dist, method = "average")
hc.c <- hclust(nb.dist, method = "complete")
# hc.m <- hclust(nb.dist, method = "single")

avg_sil_hc <- tibble(
  k = 2:kmax,
  avg_sil = map_dbl(2:kmax, hc_sil, hc = hc.c, hc_dist = nb.dist)
)

# sensibilidade - full dataset --------------------------------------------

nb.fd <- data.raw %>%
  # mutate(posicao = posicao +1) %>% # recentrar posicao entre 0 e 2
  select(id, evangelico, where(is.numeric), -starts_with("perc"))

# dataframe para elbow plot
elbow.fd <- tibble(
  k = 1:kmax,
  withinss = map_dbl(1:kmax, km_ss, data = nb.fd[, -c(1:2)])
  )

nb.dist.fd <- dist(nb.fd[, -c(1:2)])
hc.c.fd <- hclust(nb.dist.fd, method = "complete")
avg_sil_hc.fd <- tibble(
  k = 2:kmax,
  avg_sil = map_dbl(2:kmax, hc_sil, hc = hc.c.fd, hc_dist = nb.dist.fd)
)

# diagnosticos ------------------------------------------------------------

nb$cl2 <- cutree(hc.c, k = 2)
nb$cl4 <- cutree(hc.c, k = 4)

nb.fd$cl2 <- cutree(hc.c.fd, k = 2)
nb.fd$cl4 <- cutree(hc.c.fd, k = 4)

hc2_sil <- silhouette(cutree(hc.c, 2), nb.dist)
hc4_sil <- silhouette(cutree(hc.c, 4), nb.dist)

# BSS/TSS em k=2 (obj secundário)
km2 <- kmeans(nb[, -c(1:2)], centers = 2, nstart = 10)
km2.fd <- kmeans(nb.fd[, -c(1:2)], centers = 2, nstart = 10)
pct.km2 <- km2$betweenss / km2$totss
pct.km2.fd <- km2.fd$betweenss / km2.fd$totss

# BSS/TSS em k=3 (obj primário)
km3 <- kmeans(nb[, -c(1:2)], centers = 3, nstart = 10)
km3.fd <- kmeans(nb.fd[, -c(1:2)], centers = 3, nstart = 10)
pct.km3 <- km3$betweenss / km3$totss
pct.km3.fd <- km3.fd$betweenss / km3.fd$totss
