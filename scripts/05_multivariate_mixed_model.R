# =======================================
# Linear Mixed Multivariable Model comparing Datasets A and B
# =======================================

# The linear mixed multivariable model allows you to model several jump metrics together, account for repeated measures within athlete, and compare Dataset A vs Dataset B in one framework

library(dplyr)

install.packages("brms")

library(brms)

# ---------------------------------------
# 1) Combine the two datasets and label their source
# ---------------------------------------

Dataset_A_in_$dataset <- "A"
Dataset_B_in_$dataset <- "B"

combined_df <- bind_rows(Dataset_A_in_, Dataset_B_in_) %>%
  mutate(
    dataset = factor(dataset),
    AthDeId = factor(AthDeId),
    AthleteUnique = factor(paste0(dataset, "_", AthDeId)),
    Date = as.Date(Date, format = "%m/%d/%Y")
  ) %>%

# ---------------------------------------
  # 2) Make date numeric and centered for modeling
# ---------------------------------------
  mutate(
    date_num = as.numeric(Date - min(Date, na.rm = TRUE)),
    date_z = as.numeric(scale(date_num))
  ) %>%

# ---------------------------------------
  # 3) Rename columns so the model formula is easier to read
# ---------------------------------------
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

# ---------------------------------------
# 4) Fit the multivariate mixed model
# ---------------------------------------

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

# ---------------------------------------
# RESULTS
# ---------------------------------------

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

