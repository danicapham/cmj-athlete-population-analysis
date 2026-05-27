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

# DATASET B

CMJ_B <- Dataset_B_in_ %>%
  filter(`Test Type` == "CMJ", `Additional Load [lb]` == 0)

#check repeated measures per athlete --> dependent observations
CMJ_B %>%
  count(AthDeId) %>%
  summary()

# Do these repeated IDs correlate with time?

CMJ_B$Date <- as.Date(CMJ_B$Date, format = "%m/%d/%Y")
