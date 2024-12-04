#### Preamble ####
# Purpose: Models for divorce and marriage rate over the years
  #including marriage rate per age range over the years
# Author: Sarah Lee
# Date: 28 November 2024 
# Contact: sarahhhh.lee@mail.utoronto.ca 
# License: MIT
# Pre-requisites: Parquet file for divorce and marriage data

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(rstanarm)

#### Read data ####
# Read the two datasets
divorce_clean <- read_parquet("data/02-analysis_data/divorce_cleaned.parquet")
marriage_clean <- read_parquet("data/02-analysis_data/marriage_cleaned.parquet")

# Select the relevant columns: year and rate (divorce_rate, total_mRate)
divorce_rate_data <- divorce_clean |>
  select(year, divorce_rate)

marriage_rate_data <- marriage_clean |>
  select(year, total_mRate)

# Merge the data by year
combined_rate_data <- merge(divorce_rate_data, marriage_rate_data, by = "year", all = TRUE)


combined_rate_data <- combined_rate_data |>
  drop_na()  # Removes rows with any NA values

### Model data ####
# model for marriage and divorce rate per year
first_model <- stan_glm(
  formula = divorce_rate ~ total_mRate + year,  # Dependent variable: divorce_rate, Independent variables: marriage_rate, year
  data = combined_rate_data,  # The combined data
  family = gaussian(),  # Assuming a Gaussian distribution (continuous response variable)
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),  # Normal prior for coefficients
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for the intercept
  prior_aux = exponential(rate = 1, autoscale = TRUE),  # Prior for residual variance
  seed = 853  # Random seed for reproducibility
)

# model for marriage rate per age range
second_model <- 
  stan_glm(
    formula = total_mRate ~ year + `20_24_mRate` + `25_29_mRate` + `30_34_mRate` + `35_39_mRate` +
      `40_44_mRate` + `45_49_mRate` + `50_54_mRate` + `55_59_mRate` + `60_64_mRate` + 
      `65_69_mRate` + `70_74_mRate` + `75_79_mRate` + `80_over_mRate`,  # Using age group marriage rates
    data = marriage_clean,                    # Your dataset
    family = gaussian(),                     # Gaussian distribution (continuous outcome)
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for coefficients
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),  # Prior for intercept
    prior_aux = exponential(rate = 1, autoscale = TRUE),  # Prior for residual variance (sigma)
    seed = 853  # Set seed for reproducibility
  )

#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

saveRDS(
  second_model,
  file = "models/second_model.rds"
)




# Summarize the model results
summary(first_model)

# Optionally, plot posterior distributions and diagnostics
plot(first_model)

# Check diagnostics
print(first_model)

# Posterior predictive checks
pp_check(first_model)

summary(second_model)


