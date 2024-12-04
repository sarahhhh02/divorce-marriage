#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Australian 
  #electoral divisions dataset.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)

# Load dataset
analysis_data <- read_csv("data/00-simulated_data/simulated_data2.csv")  # Update with your actual data file path

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 151 rows (update based on the number of rows in your dataset)
if (nrow(analysis_data) == 151) {
  message("Test Passed: The dataset has 151 rows.")
} else {
  stop("Test Failed: The dataset does not have 151 rows.")
}

# Check if the dataset has the expected number of columns (3 or more, depending on your data)
if (ncol(analysis_data) >= 3) {
  message("Test Passed: The dataset has the expected number of columns.")
} else {
  stop("Test Failed: The dataset does not have the expected number of columns.")
}

# Check if there are no missing values in the dataset
if (all(!is.na(analysis_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if the 'MarriageRate' and 'DivorceRate' columns are numeric (as expected for rate data)
if (is.numeric(analysis_data$MarriageRate) & is.numeric(analysis_data$DivorceRate)) {
  message("Test Passed: 'MarriageRate' and 'DivorceRate' columns are numeric.")
} else {
  stop("Test Failed: 'MarriageRate' or 'DivorceRate' columns are not numeric.")
}

# Check if 'Year' is a valid numeric or integer type (this is important for time-related analysis)
if (is.numeric(analysis_data$Year)) {
  message("Test Passed: 'Year' column is numeric.")
} else {
  stop("Test Failed: 'Year' column is not numeric.")
}

# Check if the 'AgeRange' column contains expected age groups (this assumes 'AgeRange' is in the dataset)
valid_age_ranges <- c("under 20", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", 
                      "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "over 80")

if (all(analysis_data$AgeRange %in% valid_age_ranges)) {
  message("Test Passed: The 'AgeRange' column contains only valid age ranges.")
} else {
  stop("Test Failed: The 'AgeRange' column contains invalid age ranges.")
}

# Check if there are no empty strings in 'AgeRange', 'MarriageRate', or 'DivorceRate' columns
if (all(analysis_data$AgeRange != "" & !is.na(analysis_data$MarriageRate) & !is.na(analysis_data$DivorceRate))) {
  message("Test Passed: There are no empty strings or NA values in critical columns.")
} else {
  stop("Test Failed: There are empty strings or NA values in one or more critical columns.")
}

# Check if there are at least two unique age ranges in the 'AgeRange' column
if (n_distinct(analysis_data$AgeRange) >= 2) {
  message("Test Passed: The 'AgeRange' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'AgeRange' column contains less than two unique values.")
}