library(readr)
library(rsample)
library(workflows)
library(kknn)
library(parsnip)

data <- readr::read_csv("output/penguins_model.csv") %>%
  dplyr::mutate(species = as.factor(species))

# Split data
set.seed(123)
data_split <- rsample::initial_split(data, strata = species)
train_data <- rsample::training(data_split)
test_data <- rsample::testing(data_split)

# Define model
penguin_model <- parsnip::nearest_neighbor(mode = "classification", neighbors = 5) %>%
  parsnip::set_engine("kknn")

# Create workflow
penguin_workflow <- workflows::workflow() %>%
  workflows::add_model(penguin_model) %>%
  workflows::add_formula(species ~ .)

# Fit model
penguin_fit <- penguin_workflow %>%
  parsnip::fit(data = train_data)

readr::write_csv(train_data, "output/train_data.csv")
readr::write_csv(test_data, "output/test_data.csv")
readr::write_rds(penguin_fit, "output/penguin_fit.RDS")