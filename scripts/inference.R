# setup -------------------------------------------------------------------

# tables ------------------------------------------------------------------

tab_cl4 <- nb %>%
  select(evangelico, total_receita, everything()) %>%
  tbl_summary(
    by = cl4,
    include = -cl2
    ) %>%
  bold_labels() %>%
  modify_table_styling(columns = "label", align = "c")
tab_cl2 <- nb %>%
  select(evangelico, total_receita, everything()) %>%
  tbl_summary(
    by = cl2,
    include = -cl4
  ) %>%
  bold_labels() %>%
  modify_table_styling(columns = "label", align = "c")

# tab_clu <- tbl_merge(list(
#   tab_cl4,
#   tab_cl2
# ), tab_spanner = c("**k = 4**", "**k = 2**"))
