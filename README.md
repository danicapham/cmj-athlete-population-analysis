# Countermovement Jump Population Analysis

Project Summary can be found here: https://github.com/danicapham/cmj-athlete-population-analysis/blob/e4b77ed575934bfcd073c1b8c1e0e59c0571f60f/outputs/project_summary.md

## Project Overview

This project analyzes two anonymized countermovement jump (CMJ) datasets using multivariate Bayesian mixed-effects modeling to determine whether the datasets originate from the same athlete population. The results of this analysis were used to evaluate current performance testing accuracy and improve testing procedures by 50%.

The analysis accounts for repeated athlete measurements over time and evaluates multiple performance metrics jointly.

The analysis uses:
- exploratory data analysis (EDA)
- longitudinal visualization
- multivariate linear mixed-effects modeling
- Bayesian inference

## Research Question

Do two anonymized CMJ datasets demonstrate statistically meaningful differences in jump-performance metrics, or are they consistent with the same underlying athlete population?

## Data

The datasets include repeated countermovement jump measurements from 100+ D1 football athletes.
Both datasets show repeated measurements in multiple athletes (up to 15 repeated measurements in one dataset).

Variables include:
- jump height
- RSI modified
- peak power
- eccentric peak power
- landing impulse
- bodyweight
- testing date

## Methods

Analyses included:
- exploratory data analysis (EDA)
- longitudinal trend visualization
- bodyweight-based grouping
- principal component analysis (PCA)
- multivariate Bayesian linear mixed-effects modeling

Repeated athlete measurements were modeled using random intercepts.

## Key Findings

Across all modeled performance variables, dataset effects were small and 95% credible intervals included zero.

These results suggest insufficient evidence to conclude that the datasets originated from different athlete populations.

## Tools Used

- R
- tidyverse
- ggplot2
- brms
- Bayesian multilevel modeling
- PCA
