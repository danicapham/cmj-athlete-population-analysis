# cmj-athlete-population-analysis

**Project Overview**

This project analyzes two anonymized countermovement jump (CMJ) datasets to determine whether they originate from the same underlying football athlete population.

The analysis uses:
- exploratory data analysis (EDA)
- longitudinal visualization
- multivariate linear mixed-effects modeling
- Bayesian inference

**Research Question**

Do two anonymized CMJ datasets demonstrate statistically meaningful differences in athlete performance metrics?

**Methods**

A multivariate Bayesian mixed-effects model was implemented using the `brms` package in R.

Outcomes included:
- jump height
- RSI modified
- peak power
- eccentric peak power
- landing impulse

Repeated measures within athletes were modeled as random effects.

**Key Findings**

Across all modeled performance variables, dataset effects were small and 95% credible intervals included zero.

These results suggest insufficient evidence to conclude that the datasets originated from different athlete populations.

**Tools Used**

- R
- tidyverse
- ggplot2
- brms
- Bayesian multilevel modeling
