library(readr)
library(dplyr)
library(ggplot2)

data <- readr::read_csv("output/penguins.csv")

# Summary statistics
dplyr::glimpse(data)
dplyr::summarise(data, mean_bill_length = mean(bill_length_mm), mean_bill_depth = mean(bill_depth_mm))

# Visualizations
ggplot2::ggplot(data, ggplot2::aes(x = species, y = bill_length_mm, fill = species)) +
  ggplot2::geom_boxplot() +
  ggplot2::theme_minimal()

# Prepare data for modeling
data <- dplyr::select(data, species, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) %>%
  dplyr::mutate(species = as.factor(species))

readr::write_csv(data, "output/penguins_model.csv")