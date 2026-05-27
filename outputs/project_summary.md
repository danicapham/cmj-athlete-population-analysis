# Project Summary

## Objective

The objective of this project was to evaluate whether two anonymized countermovement jump (CMJ) datasets originated from the same underlying collegiate football athlete population. In addition to comparing athlete-performance metrics, the project aimed to assess the reliability and consistency of current performance-testing procedures and identify opportunities to improve future athlete monitoring and data collection workflows.

---

## Dataset Overview

The datasets contained repeated CMJ measurements collected longitudinally from collegiate football athletes. Performance variables included:

- Jump Height
- RSI Modified
- Peak Power
- Eccentric Peak Power
- Landing Impulse

Because athletes were tested multiple times over the season, repeated-measures statistical methods were required to appropriately model athlete-level variability over time.

---

## Exploratory Data Analysis

### Jump Height Trends Over Time

Longitudinal trend visualization showed expected differences between bodyweight classes, with Skill athletes (< 95 kg) generally demonstrating greater jump performance than Big Skill (95-110 kg) and Big (> 110 kg) athletes. However, overall trends across datasets remained visually similar over time, suggesting consistent testing behavior across athlete groups.

### Density Plots

Density plots demonstrated substantial overlap between Dataset A and Dataset B across all major CMJ performance variables. No major shifts in distribution shape, central tendency, or spread were observed between datasets.

These findings provided preliminary evidence that both datasets may represent the same underlying athlete population.

<img width="750" height="587" alt="density_jumpheight" src="https://github.com/user-attachments/assets/5e67218e-a078-4b8f-af5b-fd8d93bef25f" />
<img width="754" height="589" alt="density_rsi" src="https://github.com/user-attachments/assets/836d95fc-1d85-49da-a636-c61c120171b6" />
<img width="760" height="591" alt="density_peakpower" src="https://github.com/user-attachments/assets/9e6d7f7c-8913-45e4-bb1a-e60f61a03621" />
<img width="757" height="587" alt="density_landingimpulse" src="https://github.com/user-attachments/assets/78ae712d-25f4-48fe-83f8-8650d314cfb5" />

---

## Correlation Heatmap

Correlation analysis demonstrated strong positive relationships between:

- Jump Height and RSI Modified
- Jump Height and Peak Power
- RSI Modified and Peak Power

These relationships aligned with expected biomechanical performance characteristics in collegiate football athletes, supporting the validity and internal consistency of the collected testing data.

Landing impulse demonstrated weaker and partially inverse relationships with explosive performance metrics, suggesting it may capture a different aspect of athlete movement strategy and force absorption.

<img width="731" height="594" alt="correlation_heatmap" src="https://github.com/user-attachments/assets/8b53d4b4-a059-4caa-bee0-1eedfaebc605" />

---

## Principal Component Analysis (PCA)

Principal Component Analysis (PCA) was used to evaluate whether the datasets occupied similar multivariate performance space across all CMJ variables simultaneously.

The PCA plot demonstrated substantial overlap between Dataset A and Dataset B, with no clear clustering or separation between datasets. This indicated that athletes from both datasets exhibited highly similar multivariate performance profiles.

The PCA findings visually supported the hypothesis that both datasets were statistically consistent with the same athlete population.

<img width="754" height="593" alt="pca_analysis" src="https://github.com/user-attachments/assets/43c69b9a-38f4-4a84-b98f-d29bdb1dc76f" />

---

## Multivariate Mixed-Effects Modeling

A multivariate Bayesian linear mixed-effects model was implemented using repeated athlete measurements while accounting for temporal trends and athlete-level random effects.

The model simultaneously evaluated:

- Jump Height
- RSI Modified
- Peak Power
- Eccentric Peak Power
- Landing Impulse

Dataset source was modeled as a fixed effect, while athlete identity was modeled as a random effect to account for repeated measurements within athletes.

### Forest Plot Interpretation

Forest plots of model-estimated dataset effects showed that all 95% credible intervals overlapped zero across the evaluated performance metrics.

This indicated insufficient evidence of systematic differences between Dataset A and Dataset B.

Additionally, athlete-level variability was substantially larger than estimated dataset effects, suggesting that observed variation was primarily driven by normal athlete-to-athlete performance differences rather than inconsistencies in testing procedures or data collection.

<img width="732" height="592" alt="forestplot" src="https://github.com/user-attachments/assets/4913e177-eb2a-4a66-bec7-7e12dad68556" />

---

## Key Findings

- CMJ performance metrics demonstrated expected biomechanical relationships across athletes.
- Density plots and PCA demonstrated substantial overlap between datasets.
- Mixed-effects modeling showed no strong evidence of systematic differences between datasets.
- Athlete-level variability was considerably larger than dataset-level variability.
- Observed temporal trends were minor relative to overall athlete-performance variability.

---

## Operational Impact

This project provided evidence supporting the reliability and consistency of current CMJ testing procedures within the athlete monitoring pipeline.

The analysis improved confidence in the validity of longitudinal performance testing data and informed recommendations for:

- improved testing standardization
- enhanced longitudinal athlete monitoring
- and more consistent future data-collection workflows.

The project demonstrated how advanced statistical modeling and visualization techniques can support evidence-based decision-making in sports performance analytics.

---

## Conclusion

Across exploratory visualization, PCA, correlation analysis, and multivariate Bayesian mixed-effects modeling, the datasets demonstrated highly similar performance characteristics and substantial statistical overlap.

The analysis found insufficient evidence to conclude that the datasets originated from different athlete populations. Instead, results suggest that both datasets are statistically consistent with the same underlying collegiate football athlete population.

Overall, the project validated current testing procedures while providing a framework for improving future athlete-performance monitoring and data quality assessment.
