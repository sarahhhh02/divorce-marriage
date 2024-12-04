#### Preamble ####
# Purpose: Tests cleaned version of marriage and divorce data
# Author: Sarah Lee
# Date: 28 Novemeber 2024
# Contact: sarahhhh.lee@mail.utoronto.ca 
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(testthat)

data <- read_csv("data/02-analysis_data/divorce_cleaned.csv")

#### Test data ####
# Test that the dataset has 51 rows - there are 151 divisions in Australia
test_that("dataset has 51 rows", {
  expect_equal(nrow(analysis_data), 51)
})

# Test that the dataset has 11 columns
test_that("dataset has 11 columns", {
  expect_equal(ncol(analysis_data), 11)
})

# Test that the 'year' column is integer type (since the year is numerical)
test_that("'year' is integer", {
  expect_type(data$year, "integer")
})

# Test that the 'divorce_num' column is numeric (divorce counts are numeric)
test_that("'divorce_num' is numeric", {
  expect_type(data$divorce_num, "double")
})

# Test that the 'divorce_crude' column is numeric
test_that("'divorce_crude' is numeric", {
  expect_type(data$divorce_crude, "double")
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(data)))
})

# Test that 'year' contains unique values (there should be one entry per year)
test_that("'year' column contains unique values", {
  expect_equal(length(unique(data$year)), 51)
})

# Test that 'divorce_rate' column contains no missing values
test_that("'divorce_rate' contains no missing values", {
  expect_true(all(!is.na(data$divorce_rate)))
})

# Test that the 'divorce_age' column is numeric (the age should be a number)
test_that("'divorce_age' is numeric", {
  expect_type(data$divorce_age, "double")
})

# Test that the 'divorce_30' column is numeric
test_that("'divorce_30' is numeric", {
  expect_type(data$divorce_30, "double")
})

# Test that the 'divorce_50' column is numeric
test_that("'divorce_50' is numeric", {
  expect_type(data$divorce_50, "double")
})

# Test that there are no empty strings in 'year', 'divorce_num', or 'divorce_crude' columns
test_that("no empty strings in 'year', 'divorce_num', or 'divorce_crude' columns", {
  expect_false(any(data$year == "" | data$divorce_num == "" | data$divorce_crude == ""))
})

# Test that the 'divorce_num' column contains only positive values (there should be no negative divorce counts)
test_that("'divorce_num' contains only positive values", {
  expect_true(all(data$divorce_num > 0))
})

# Test that 'divorce_rate' column does not have values greater than 10 (reasonable range based on the data)
test_that("'divorce_rate' does not exceed 10", {
  expect_true(all(data$divorce_rate <= 10))
})