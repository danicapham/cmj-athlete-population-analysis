# =======================================
# Visualizations for CMJ Population Analysis
# =======================================

library(tidyverse)
library(moderndive)
library(infer)
library(ggplot2)
library(dplyr)

# ---------------------------------------
# 1) mixed-model effects forest plot
# ---------------------------------------



# ---------------------------------------
# 2) Density plots comparing Dataset A and B
# ---------------------------------------

# jump height
ggplot(combined_df,
       aes(x = jump_height,
           fill = dataset,
           color = dataset)) +
  geom_density(alpha = 0.3) +
  labs(title = "Jump Height Distribution by Dataset",
       x = "Jump Height (in)",
       y = "Density")

# The distribution overlap heavily, but Dataset A appears to have a slightly higher density of jump heights around 20-25 inches, while Dataset B has a slightly higher density around 10-15 inches. However, the overall shapes of the distributions are similar, and there is substantial overlap, which is consistent with the model results indicating no significant differences between datasets.

# RSI modified
ggplot(combined_df,
       aes(x = rsi_mod,
           fill = dataset,
           color = dataset)) +
  geom_density(alpha = 0.3) +
  labs(title = "RSI Distribution by Dataset",
       x = "RSI (m/s)",
       y = "Density")

# The distributions for RSI modified also show substantial overlap between datasets, with similar shapes and central tendencies. There may be a slightly higher density of RSI values around 0.7-0.9 m/s in Dataset A compared to Dataset B, but overall the distributions are quite similar, which again aligns with the model findings of no significant differences.

# peak power
ggplot(combined_df,
       aes(x = peak_power,
           fill = dataset,
           color = dataset)) +
  geom_density(alpha = 0.3) +
  labs(title = "Peak Power Distribution by Dataset",
       x = "Peak Power / BM (W/kg)",
       y = "Density")

# The peak power distributions also show substantial overlap, with similar shapes and central tendencies. There may be a slightly higher density of peak power values around 50-60 W/kg in Dataset B compared to Dataset A, but overall the distributions are quite similar, which is consistent with the model results indicating no significant differences between datasets.

# landing impulse
ggplot(combined_df,
       aes(x = landing_impulse,
           fill = dataset,
           color = dataset)) +
  geom_density(alpha = 0.3) +
  labs(title = "Landing Impulse Distribution by Dataset",
       x = "Landing Impulse (N s)",
       y = "Density")

# The landing impulse distributions show substantial overlap, with similar shapes and central tendencies. There may be a slightly higher density of landing impulse values around 50-100 N s in Dataset A compared to Dataset B, but overall the distributions are quite similar, which is consistent with the model findings of no significant differences between datasets.

# ---------------------------------------
# 3) Correlation heatmap
# ---------------------------------------

library(corrplot)

vars <- combined_df %>%
  select(jump_height,
         rsi_mod,
         peak_power,
         ecc_peak_power,
         landing_impulse)

cor_matrix <- cor(vars, use = "complete.obs")

corrplot(cor_matrix, method = "color")

# The heatmap shows a strong correlation between jump height, RSI modified, and peak power but a weaker correlation with landing impulse.
