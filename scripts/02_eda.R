# INTRODUCTION

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


