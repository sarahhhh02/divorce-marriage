#### Preamble ####
# Purpose: Simulates a dataset of divorce and marriage rates over time 
  #inclduing age range in marriage
# Author: Sarah Lee
# Date: 28 November 2024
# Contact: sarahhhh.lee@mail.utoronto.ca 
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `divorce-marriage` rproj


#### Workspace setup ####
library(tidyverse)

#set seed for reproducibility 
set.seed(853)

#### Simulate data ####

###correlation between divorce and marriage###
n <- 100  # number of observations
marriage_rate <- rnorm(n, mean = 6, sd = 1)  # Marriage rate per 1,000 people

# Simulate divorce rate with a positive correlation to marriage rate
divorce_rate <- 0.5 * marriage_rate + rnorm(n, mean = 0, sd = 0.5)

# Combine into a data frame
simulated_data1 <- data.frame(
  MarriageRate = marriage_rate,
  DivorceRate = divorce_rate
)

# View the first few rows
head(simulated_data1)

###changes over time in divorce and marriage over years for age###
year <- 1970:2020
age_ranges <- c("under 20", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", 
                "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "over 80") 

# Create a data frame
simulated_data2 <- expand.grid(
  Year = year,
  AgeRange = age_ranges
)

n <- nrow(simulated_data2)  # Number of rows in simulated_data

# Simulate marriage rates with age-specific trends
simulated_data2$MarriageRate <- with(simulated_data2,
                                    ifelse(AgeRange == "under 20", 
                                           10 - 0.2 * (Year - min(Year)) + rnorm(n, 0, 0.5),  # Sharp decline
                                           ifelse(AgeRange %in% c("20-24", "25-29"), 
                                                  8 - 0.1 * (Year - min(Year)) + rnorm(n, 0, 0.5),  # Gradual decline
                                                  ifelse(AgeRange %in% c("30-34", "35-39"), 
                                                         5 + 0.05 * (Year - min(Year)) + rnorm(n, 0, 0.4),  # Slight increase
                                                         2 + 0.02 * (Year - min(Year)) + rnorm(n, 0, 0.3)))))  # Slow increase for older ages

# Simulate divorce rates based on marriage rates and age-specific adjustments
simulated_data2$DivorceRate <- with(simulated_data2,
                                   0.4 * MarriageRate + 
                                     ifelse(AgeRange == "under 20", 
                                            0.1 * (Year - min(Year)),  # Gradual increase for younger groups
                                            ifelse(AgeRange %in% c("20-24", "25-29"), 
                                                   0.05 * (Year - min(Year)),  # Moderate increase
                                                   ifelse(AgeRange %in% c("30-34", "35-39"), 
                                                          -0.02 * (Year - min(Year)),  # Slight decline
                                                          -0.01 * (Year - min(Year)))))) + 
  rnorm(n, 0, 0.3)  # Noise


# View the first few rows to check the data
head(simulated_data2)



#### Save data ####
write_csv(simulated_data1, "data/00-simulated_data/simulated_data1.csv")
write_csv(simulated_data2, "data/00-simulated_data/simulated_data2.csv")

