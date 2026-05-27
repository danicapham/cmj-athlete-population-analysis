# =======================================
# PCA Analysis
# =======================================

install.packages("FactoMineR")
install.packages("rlang")

library(FactoMineR)

library(factoextra)

pca_data <- combined_df %>%
  select(jump_height,
         rsi_mod,
         peak_power,
         ecc_peak_power,
         landing_impulse) %>%
  na.omit()

pca <- PCA(pca_data, graph = FALSE)

# ---------------------------------------
# PCA Plot
# ---------------------------------------

fviz_pca_ind(
  pca,
  habillage = combined_df$dataset,
  addEllipses = TRUE
)

# The PCA plot shows that there is considerable overlap between Dataset A and Dataset B in the PCA space. The ellipses representing each dataset overlap significantly, which visually supports the conclusion from the multivariate model that there are no systematic differences between the datasets.

