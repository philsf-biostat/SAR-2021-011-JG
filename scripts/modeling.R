# setup -------------------------------------------------------------------
# library(gt)
# library(gtsummary)
# library(moderndive)
# library(broom)
# library(broom.mixed)
library(dendextend)
library(ggdendro)
library(cluster)

# kmeans ------------------------------------------------------------------

nb <- analytical %>%
  select(evangelico, where(is.numeric))

cl <- c()

kmax <- 10

for (i in 1:kmax) {
  cl[i] <- kmeans(nb[, -1], centers = i)$tot.withinss
}

nb$km2 <- kmeans(nb[, -1], 2)$cluster
nb$km4 <- kmeans(nb[, -1], 4)$cluster

# dataframe para elbow plot
elbow <- tibble(k = 1:kmax, withinss = cl)

# cluster hierárquico -----------------------------------------------------

hc.a <- hclust(dist(nb[, -1]), method = "average")
hc.c <- hclust(dist(nb[, -1]), method = "complete")
hc.m <- hclust(dist(nb[, -1]), method = "single")

# sensibilidade - full dataset --------------------------------------------

nb.fd <- data.raw %>%
  select(evangelico, where(is.numeric), -starts_with("perc")) %>%
  mutate(posicao = posicao +1) # recentrar posicao entre 0 e 2

cl.fd <- c()

for (i in 1:kmax) {
  cl.fd[i] <- kmeans(nb.fd[, -1], centers = i)$tot.withinss
}

nb.fd$km2 <- kmeans(nb.fd[, -1], 2)$cluster
nb.fd$km4 <- kmeans(nb.fd[, -1], 4)$cluster

# dataframe para elbow plot
elbow.fd <- tibble(k = 1:kmax, withinss = cl.fd)

# diagnosticos ------------------------------------------------------------

km2_a <- analytical %>% select_if(is.numeric) %>% kmeans(centers = 2)
km2_t <- data.raw   %>% select_if(is.numeric) %>% kmeans(centers = 2)

# kmeans com 2 clusters
CrossTable(km2_a$cluster, analytical$evangelico, mcnemar = TRUE)
CrossTable(km2_t$cluster, data.raw$evangelico, mcnemar = TRUE)
