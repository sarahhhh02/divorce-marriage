#### Preamble ####
# Purpose: Cleans the raw divorce and marriage rate data
# Author: Sarah Lee
# Date: 28 November 2024
# Contact: sarahhhh.lee@mail.utoronto.ca 
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean divorce data ####
#retrieve data from folders
divorce_raw <- read_csv("data/01-raw_data/divorce_raw.csv")

#only select the rows that are needed
divorce<- 
  divorce_raw |>
  select(REF_DATE, Indicator, VALUE)

#collect same string from indicator column and make them as their own column
divorce_clean <- divorce |>
  pivot_wider(names_from = Indicator, values_from = VALUE)

#rename columns
divorce_clean <- divorce_clean |>
  rename(
    divorce_num = `Number of divorces`,  
    divorce_crude = `Crude divorce rate`,
    divorce_rate = `Divorce rate`,
    divorce_age = `Age-standardized divorce rate`,
    divorce_30 = `30-year total divorce rate`,
    divorce_50 = `50-year total divorce rate`,
    divorce_marriage_mean = `Mean duration of marriage`,
    divorce_marriage_median = `Median duration of marriage`,
    divorce_proceeding = `Median duration of divorce proceedings`,
    divorce_application = `Proportion of divorce applications that are filed jointly`,
    year = REF_DATE
  )
  
#### Save divorce data ####
write_csv(divorce_clean, "data/02-analysis_data/divorce_cleaned.cvs")
write_parquet(divorce_clean, "data/02-analysis_data/divorce_cleaned.parquet")

#### Clean marriage data ####
#retrieve data from folders
marriage_raw <- read_csv("data/01-raw_data/marriage_raw.csv")

#only select the rows that are needed
marriage <- 
  marriage_raw |>
  select(REF_DATE, Indicator, VALUE, `Age at marriage`)

#collect same string from indicator and age column and make them as their own column
marriage_clean <- marriage |>
  pivot_wider(names_from = c(Indicator, `Age at marriage`),  values_from = VALUE)

#rename columns
marriage_clean <- marriage_clean |>
  rename(
    total_married = `Number of persons who married_Total – Age`,  
    `20_under_married` = `Number of persons who married_Under 20 years`,
    `20_24_married` = `Number of persons who married_20 to 24 years`,
    `25_29_married` = `Number of persons who married_25 to 29 years`,
    `30_34_married` = `Number of persons who married_30 to 34 years`,
    `35_39_married` = `Number of persons who married_35 to 39 years`,
    `40_44_married` = `Number of persons who married_40 to 44 years`,
    `45_49_married` = `Number of persons who married_45 to 49 years`,
    `50_54_married` = `Number of persons who married_50 to 54 years`,
    `55_59_married` = `Number of persons who married_55 to 59 years`,
    `60_64_married` = `Number of persons who married_60 to 64 years`,  
    `65_69_married` = `Number of persons who married_65 to 69 years`,
    `70_74_married` = `Number of persons who married_70 to 74 years`,
    `75_79_married` = `Number of persons who married_75 to 79 years`,
    `80_over_married` = `Number of persons who married_80 years and over`,
    total_mRate = `Marriage rate_Total – Age`,
    `20_under_mRate` = `Marriage rate_Under 20 years`,
    `20_24_mRate` = `Marriage rate_20 to 24 years`,
    `25_29_mRate` = `Marriage rate_25 to 29 years`,
    `30_34_mRate` = `Marriage rate_30 to 34 years`,
    `35_39_mRate` = `Marriage rate_35 to 39 years`,  
    `40_44_mRate` = `Marriage rate_40 to 44 years`,
    `45_49_mRate` = `Marriage rate_45 to 49 years`,
    `50_54_mRate` = `Marriage rate_50 to 54 years`,
    `55_59_mRate` = `Marriage rate_55 to 59 years`,
    `60_64_mRate` = `Marriage rate_60 to 64 years`,
    `65_69_mRate` = `Marriage rate_65 to 69 years`,
    `70_74_mRate` = `Marriage rate_70 to 74 years`,
    `75_79_mRate` = `Marriage rate_75 to 79 years`,
    `80_over_mRate` = `Marriage rate_80 years and over`,
    year = REF_DATE
  )

#### Save divorce data ####
write_csv(marriage_clean, "data/02-analysis_data/marriage_cleaned.cvs")
write_parquet(marriage_clean, "data/02-analysis_data/marriage_cleaned.parquet")
