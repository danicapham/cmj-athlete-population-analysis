## INTRODUCTION

#Task: Identify differences between Dataset A and B 
#Report any findings concisely 

#Subtasks: Ensure data is clean, check all assumptions made about data 
#Example: Data independent by date? 

#Materials: 2 Anonymized Counter-Movement Jump Datasets 

# ASSUMPTIONS

#Tests are labeled correctly

#Tests are standardized and conducted correctly

# OBSERVATIONS

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

------------------------------------------

# EDA: DATASET A

# separate dataset into Skill, Big Skill, and Bigs by bodyweight

CMJ_A$position_group <- cut(
  CMJ_A$`BW [KG]`,
  breaks = c(-Inf, 95, 110, Inf),
  labels = c("Skill", "Big Skill", "Bigs")
)

# Jump Height for each group
ggplot(CMJ_A, aes(x = Date, y = `Jump Height (Imp-Mom) in Inches [in]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# Observation: on average, the jump height appears to be higher for athletes with lower bodyweight than with higher bodyweight

# Jump Height vs RSI modified

ggplot(CMJ_A, aes(x = `Jump Height (Imp-Mom) in Inches [in]`, y = `RSI-modified (Imp-Mom) [m/s]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# Observation: jump height seems to correlate with RSI modified positively, but not completely

# Jump Height vs Peak Power

ggplot(CMJ_A, aes(x = `Jump Height (Imp-Mom) in Inches [in]`, y = `Peak Power / BM [W/kg]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# Observation: jump height seems to correlate with peak power positively

# EDA: DATASET B

# separate dataset into Skill, Big Skill, and Bigs by bodyweight

CMJ_B$position_group <- cut(
  CMJ_B$`BW [KG]`,
  breaks = c(-Inf, 95, 110, Inf),
  labels = c("Skill", "Big Skill", "Bigs")
)

# Jump Height for each group
ggplot(CMJ_B, aes(x = Date, y = `Jump Height (Imp-Mom) in Inches [in]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# Observation: on average, the jump height appears to be higher for athletes with lower bodyweight than with higher bodyweight

# Jump Height vs RSI modified

ggplot(CMJ_B, aes(x = `Jump Height (Imp-Mom) in Inches [in]`, y = `RSI-modified (Imp-Mom) [m/s]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# Observation: jump height seems to correlate with RSI modified positively, but not completely

# Jump Height vs Peak Power

ggplot(CMJ_B, aes(x = `Jump Height (Imp-Mom) in Inches [in]`, y = `Peak Power / BM [W/kg]`)) + geom_point(alpha = 0.5) + geom_smooth(se=FALSE) + facet_wrap(~position_group)

# Observation: jump height seems to correlate with peak power positively

------------------------------------------

# Density plots comparing Dataset A and B

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



