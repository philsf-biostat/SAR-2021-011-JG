# setup -------------------------------------------------------------------
# library(gt)
# library(gtsummary)
# library(moderndive)
# library(broom)
# library(broom.mixed)

# kmeans ------------------------------------------------------------------

# nb <- data.raw %>%
nb <- analytical %>%
  select(evangelico, where(is.numeric)) %>%
  drop_na()


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

# diagnosticos ------------------------------------------------------------

