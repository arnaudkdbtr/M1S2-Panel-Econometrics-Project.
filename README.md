# Analysis of Fatal Road Accidents in the United States (1982-1988)

## 📌 Project Overview

This project aims to analyze the determinants of fatal road accidents in the United States using panel data from 1982 to 1988. The study explores socio-economic, policy, and behavioral factors influencing road mortality rates across 48 U.S. states. The objective is to provide insights that could help guide public policies to improve road safety.

## 📊 Dataset

The dataset comes from the `AER` package in R and is based on the *Fatalities* database, which contains annual panel data on U.S. traffic fatalities. The main sources include:

- **Bureau of Economic Analysis (BEA)**
- **National Highway Traffic Safety Administration (NHTSA)**
- **Bureau of Labor Statistics (BLS)**

### Key Variables:
- `fatalities`: Number of road fatalities per state-year.
- `income`: Per capita income.
- `unemp`: Unemployment rate.
- `spirits`: Alcohol consumption per capita.
- `beertax`: Beer tax (proxy for alcohol policies).
- `miles`: Miles driven per capita (log-transformed).
- `gsp`: Gross state product growth (log-transformed).

## 🏗 Methodology

We apply panel data econometrics to estimate the impact of economic and behavioral factors on road fatalities. The following models are compared:

1. **Pooled OLS**  
2. **Fixed Effects Model (FE)**  
3. **Random Effects Model (RE)**  

### Model Specification:

log(fatal_it) = β₀ + β₁ income_it + β₂ unemp_it + β₃ spirits_it + β₄ beertax_it + β₅ log(miles_it) + β₆ log(gsp_it) + u_it

### Model Selection:

- **Fisher Test** confirms significant individual effects → Panel models are preferred over Pooled OLS.
- **Hausman Test** rejects the exogeneity hypothesis → Fixed Effects model is more appropriate.
- **Wooldridge Test** suggests autocorrelation in Pooled OLS and Random Effects models → Fixed Effects is preferred.

## ⚙️ Implementation

The analysis is conducted in **R**, leveraging packages such as:
- `plm` (panel data modeling)
- `lmtest` (diagnostic tests)
- `car` (statistical tests)
- `stargazer` (formatted output tables)


