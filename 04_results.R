library(readr)
library(dplyr)
library(yardstick)

train_data <- readr::read_csv("data/train_data.csv") %>%
  dplyr::mutate(species = as.factor(species))
test_data <- readr::read_csv("data/test_data.csv") %>%
  dplyr::mutate(species = as.factor(species))
penguin_fit <- readr::read_rds("output/penguin_fit.RDS")

# Predict on test data
predictions <- predict(penguin_fit, new_data = test_data) %>%
  dplyr::bind_cols(test_data)

# Confusion matrix
conf_mat <- yardstick::conf_mat(predictions, truth = species, estimate = .pred_class)
conf_mat

readr::write_rds(conf_mat, "output/conf_mat.RDS")