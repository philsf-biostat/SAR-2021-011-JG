# setup -------------------------------------------------------------------
# library(tableone)
# library(gt)
# library(gtsummary)
# library(infer)

# tables ------------------------------------------------------------------

# template p-value table
# tab_inf <- analytical %>%
#   # select
#   select(-id, -uf, -partido) %>%
#   tbl_summary(
#     by = evangelico
#   ) %>%
#   # include study N
#   add_overall() %>%
#   # pretty format categorical variables
#   bold_labels() %>%
#   # bring home the bacon!
#   add_p(
#     # use Fisher test (defaults to chi-square)
#     test = all_categorical() ~ "fisher.test",
#     # use 3 digits in pvalue
#     pvalue_fun = function(x) style_pvalue(x, digits = 3)
#   ) %>%
#   # bold significant p values
#   bold_p()

# Template Cohen's D table (obs: does NOT compute p)
# tab_inf <- analytical %>%
#   # select
#   select(-id, ) %>%
#   tbl_summary(
#     by = group
#   ) %>%
#   add_difference(
#     test = all_continuous() ~ "cohens_d",
#   ) %>%
#   modify_header(estimate ~ '**d**') %>%
#   bold_labels()

tab_cl4 <- nb %>%
  select(evangelico, total_receita, everything()) %>%
  tbl_summary(
    by = cl4,
    include = -cl2
    )
tab_cl2 <- nb %>%
  select(evangelico, total_receita, everything()) %>%
  tbl_summary(
    by = cl2,
    include = -cl4
  )

# tab_clu <- tbl_merge(list(
#   tab_cl4,
#   tab_cl2
# ), tab_spanner = c("**k = 4**", "**k = 2**"))
