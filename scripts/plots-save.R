# setup -------------------------------------------------------------------
height <- 8
width <- 8
units <- "cm"

# publication ready tables ------------------------------------------------

# Don't need to version these files on git
# tab_cl4 %>%
#   as_gt() %>%
#   as_rtf() %>%
#   writeLines(con = "report/SAR-2021-012-JG-v01-T2.rtf")

# save plots --------------------------------------------------------------

ggsave(filename = "figures/receitas.png", plot = gg.receitas, height = 16, width = 16, units = units)
ggsave(filename = "figures/receita_total.png", plot = gg.rec_total, height = height, width = width, units = units)
ggsave(filename = "figures/elbow.png", plot = gg.elbow, height = height, width = width, units = units)
ggsave(filename = "figures/silhouette.png", plot = gg.sil, height = height, width = width, units = units)
ggsave(filename = "figures/dendrograma.png", plot = gg.dendro, height = height, width = width, units = units)
ggsave(filename = "figures/elbow_full.png", plot = gg.elbow.fd, height = height, width = width, units = units)
ggsave(filename = "figures/silhouette_full.png", plot = gg.sil.fd, height = height, width = width, units = units)
ggsave(filename = "figures/dendrograma_full.png", plot = gg.dendro.fd, height = 16, width = 16, units = units)

# # dendrogramas
# png(filename = "figures/arvore.png", width = 8, height = 8, units = "cm", res = 300)
# plot(hc.c %>% as.dendrogram() %>% color_branches(h = 2.6), leaflab = "none", sub = "h = 2.6", ylab = "h")
# abline(h = 2.6, col = "red", lwd = 2)
# dev.off()
# 
# png(filename = "figures/arvore_full.png", width = 16.5, height = 8, units = "cm", res = 300)
# par(mfrow = c(1,2))
# plot(hc.c.fd %>% as.dendrogram() %>% color_branches(h = 3.85), leaflab = "none")
# abline(h = 3.85, col = "blue", lwd = 2)
# plot(hc.c.fd %>% as.dendrogram() %>% color_branches(h = 2.75), leaflab = "none", sub = "h = 2.75", ylab = "h")
# abline(h = 2.75, col = "red", lwd = 2)
# par(mfrow = c(1,1))
# dev.off()
