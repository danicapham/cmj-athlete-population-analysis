#INTRODUCTION

#Task: Identify differences between datasets 
#Report any findings concisely 

#Subtasks: Ensure data is clean, check all assumptions made about data 
#Example: Data independent by date? 

#Materials: 2 Anonymized Counter-Movement Jump Datasets 

#ASSUMPTIONS

#Tests are labeled correctly

#Data independent by date

#Tests are standardized and conducted correctly

#OBSERVATIONS

#Dataset A
#Most tests are CMJ except 2 ABCMJ (273, 274).
#The ABCMJ jumps are both in the top 4 for jump height (29.1, 25.4).
#The rep range is usually 2, but there's a good amount of deviations with 1, 3, and 4.
#The dates of tests range from 6/12/25 to 8/8/25.
#Two tests have additional load of 2 and 14 respectively (127, 134).

#Dataset B
#1 test has ABCMJ (266).
#Test dates range from 6/16/25 to 8/8/25.
#No tests have additional load.
#The rep range ranges from 1-5 reps.

#STEPS
# What defines "same population"? Compare distributions of key performance variables (jump height, RSI modified, peak power, eccentric peak power, landing impulse)
# clean and filter
# exploratory data analysis
# check assumptions (normality)
# compare distributions
# multivariate comparison
# effect size

library(tidyverse)
library(moderndive)
library(infer)
library(ggplot2)
library(dplyr)

# DATASET A

# filter data
CMJ_A <- Dataset_A_in_ %>%
  filter(`Test Type` == "CMJ", `Additional Load [lb]` == 0)

#check repeated measures per athlete --> dependent observations
CMJ_A %>%
  count(AthDeId) %>%
  summary()

# Do these repeated IDs correlate with time?

CMJ_A$Date <- as.Date(CMJ_A$Date, format = "%m/%d/%Y")

# jump height
ggplot(CMJ_A, aes(x = Date, y = `Jump Height (Imp-Mom) in Inches [in]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + scale_x_date(date_breaks = "1 week", date_labels = "%m/%d") + theme(text = element_text(size=8))

# separated by each individual athlete (messy graph)
ggplot(CMJ_A, aes(x = Date, y = `Jump Height (Imp-Mom) in Inches [in]`, group = AthDeId)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + scale_x_date(date_breaks = "1 week", date_labels = "%m/%d") + theme(text = element_text(size=8))

# improvement is not necessarily linear (influenced by factors like injury, energy/sleep, motivation, how they feel that day)

# separate dataset into Skill, Big Skill, and Bigs by bodyweight and graph jump height over time for each group

CMJ_A$position_group <- cut(
  CMJ_A$`BW [KG]`,
  breaks = c(-Inf, 95, 110, Inf),
  labels = c("Skill", "Big Skill", "Bigs")
)

ggplot(CMJ_A, aes(x = Date, y = `Jump Height (Imp-Mom) in Inches [in]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# on average, the jump height appears to be higher for athletes with lower bodyweight than with higher bodyweight

# RSI modified

ggplot(CMJ_A, aes(x = `Jump Height (Imp-Mom) in Inches [in]`, y = `RSI-modified (Imp-Mom) [m/s]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# jump height seems to correlate with RSI modified positively, but not completely

# peak power

ggplot(CMJ_A, aes(x = `Jump Height (Imp-Mom) in Inches [in]`, y = `Peak Power / BM [W/kg]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# jump height seems to correlate with peak power positively

# DATASET B

CMJ_B <- Dataset_B_in_ %>%
  filter(`Test Type` == "CMJ", `Additional Load [lb]` == 0)

#check repeated measures per athlete --> dependent observations
CMJ_B %>%
  count(AthDeId) %>%
  summary()

# Do these repeated IDs correlate with time?

CMJ_B$Date <- as.Date(CMJ_B$Date, format = "%m/%d/%Y")

# jump height
ggplot(CMJ_B, aes(x = Date, y = `Jump Height (Imp-Mom) in Inches [in]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + scale_x_date(date_breaks = "1 week", date_labels = "%m/%d") + theme(text = element_text(size=8))

# separated by each individual athlete (messy graph)
ggplot(CMJ_B, aes(x = Date, y = `Jump Height (Imp-Mom) in Inches [in]`, group = AthDeId)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + scale_x_date(date_breaks = "1 week", date_labels = "%m/%d") + theme(text = element_text(size=8))

# improvement is not necessarily linear (influenced by factors like injury, energy/sleep, motivation, how they feel that day)

# separate dataset into Skill, Big Skill, and Bigs by bodyweight and graph jump height over time for each group

CMJ_B$position_group <- cut(
  CMJ_B$`BW [KG]`,
  breaks = c(-Inf, 95, 110, Inf),
  labels = c("Skill", "Big Skill", "Bigs")
)

ggplot(CMJ_B, aes(x = Date, y = `Jump Height (Imp-Mom) in Inches [in]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# on average, the jump height appears to be higher for athletes with lower bodyweight than with higher bodyweight

# RSI modified

ggplot(CMJ_B, aes(x = `Jump Height (Imp-Mom) in Inches [in]`, y = `RSI-modified (Imp-Mom) [m/s]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# jump height seems to correlate with RSI modified positively, but not completely

# peak power

ggplot(CMJ_B, aes(x = `Jump Height (Imp-Mom) in Inches [in]`, y = `Peak Power / BM [W/kg]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# jump height seems to correlate with peak power positively


# COMPARING DATASET A AND B

# linear mixed multivariable model
# allows you to model several jump metrics together, account for repeated measures within athlete, and compare Dataset A vs Dataset B in one framework

library(dplyr)

install.packages("brms")

library(brms)

# 1) Combine the two datasets and label their source
Dataset_A_in_$dataset <- "A"
Dataset_B_in_$dataset <- "B"

combined_df <- bind_rows(Dataset_A_in_, Dataset_B_in_) %>%
  mutate(
    dataset = factor(dataset),
    AthDeId = factor(AthDeId),
    AthleteUnique = factor(paste0(dataset, "_", AthDeId)),
    Date = as.Date(Date, format = "%m/%d/%Y")
  ) %>%
  # 2) Make date numeric and centered for modeling
  mutate(
    date_num = as.numeric(Date - min(Date, na.rm = TRUE)),
    date_z = as.numeric(scale(date_num))
  ) %>%
  # 3) Rename columns so the model formula is easier to read
  transmute(
    dataset,
    AthleteUnique,
    date_z,
    jump_height = `Jump Height (Imp-Mom) in Inches [in]`,
    rsi_mod = `RSI-modified (Imp-Mom) [m/s]`,
    peak_power = `Peak Power / BM [W/kg]`,
    ecc_peak_power = `Eccentric Peak Power / BM [W/kg]`,
    landing_impulse = `Landing Impulse [N s]`
  ) %>%
  tidyr::drop_na()

# 4) Fit the multivariate mixed model
mv_model <- brm(
  bf(jump_height ~ dataset + date_z + (1 | p | AthleteUnique)) +
    bf(rsi_mod ~ dataset + date_z + (1 | p | AthleteUnique)) +
    bf(peak_power ~ dataset + date_z + (1 | p | AthleteUnique)) +
    bf(ecc_peak_power ~ dataset + date_z + (1 | p | AthleteUnique)) +
    bf(landing_impulse ~ dataset + date_z + (1 | p | AthleteUnique)) +
    set_rescor(TRUE),
  data = combined_df,
  family = gaussian(),
  chains = 4,
  cores = 4,
  iter = 4000,
  warmup = 2000,
  control = list(adapt_delta = 0.95)
)

summary(mv_model)
fixef(mv_model)

# RESULTS

# Dataset A = reference, Dataset B = comparison
# jumpheight_datasetB ~ how much Dataset B differs from Dataset A

# Athletes with higher jump heights tend to have higher RSI modified and peak power, but not necessarily higher landing impulse.
# REFERENCE: cor(jumpheight_Intercept,rsimod_Intercept), cor(jumpheight_Intercept,peakpower_Intercept), cor(jumpheight_Intercept,landingimpulse_Intercept)

# Strong positive relationships: jump height ↔ RSI, jump height ↔ peak power, RSI ↔ peak power

#jumpheight_datasetB = -0.97
#95% CI = [-2.14, 0.27]

# rsimod_datasetB = -0.035
# 95% CI = [-0.086, 0.014]

#peakpower_datasetB = -3.10
#95% CI = [-6.57, 0.45]

#eccpeakpower_datasetB = -1.64
#95% CI = [-4.43, 1.17]

#landingimpulse_datasetB = 5.74
#95% CI = [-13.47, 24.19]

# A multivariate linear mixed-effects model was used to compare countermovement jump metrics between Dataset A and Dataset B while accounting for repeated measurements within athletes and temporal trends. Across jump height, RSI modified, peak power, eccentric peak power, and landing impulse, estimated dataset effects were small and all 95% credible intervals included zero. These findings indicate insufficient evidence of systematic differences between datasets, suggesting that the datasets are statistically consistent with originating from the same underlying athlete population.

# VISUALIZATIONS

# density plots

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

# PCA plot

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

fviz_pca_ind(
  pca,
  habillage = combined_df$dataset,
  addEllipses = TRUE
)

# The PCA plot shows that there is considerable overlap between Dataset A and Dataset B in the PCA space. The ellipses representing each dataset overlap significantly, which visually supports the conclusion from the multivariate model that there are no systematic differences between the datasets.

# mixed-model effects plot


# Correlation heatmap

library(corrplot)

vars <- combined_df %>%
  select(jump_height,
         rsi_mod,
         peak_power,
         ecc_peak_power,
         landing_impulse)

cor_matrix <- cor(vars, use = "complete.obs")

corrplot(cor_matrix, method = "color")






















