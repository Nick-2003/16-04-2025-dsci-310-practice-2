"This script performs exploratory data analysis (EDA) and prepares the data for modeling

Usage: src/02-methods.R --input_path=<input_path> --output_path_summary=<output_path_summary> --output_path_image=<output_path_image> --output_path_clean=<output_path_clean>

Options:
--input_path=<input_path>
--output_path_summary=<output_path_summary>
--output_path_image=<output_path_image>
--output_path_clean=<output_path_clean>
" -> doc

library(docopt)
library(tidyverse)
library(readr)
library(dplyr)
library(ggplot2)

opt <- docopt::docopt(doc)
data <- readr::read_csv(opt$input_path)

# Summary statistics
dplyr::glimpse(data)
summary <- dplyr::summarise(data, mean_bill_length = mean(bill_length_mm), mean_bill_depth = mean(bill_depth_mm), mean_flipper_length = mean(flipper_length_mm), mean_body_mass = mean(body_mass_g))

# Visualizations
boxplot_image <- ggplot2::ggplot(data, ggplot2::aes(x = species, y = bill_length_mm, fill = species)) +
  ggplot2::geom_boxplot() +
  ggplot2::theme_minimal()

# Prepare data for modeling
data <- dplyr::select(data, species, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) %>%
  dplyr::mutate(species = as.factor(species))

# Save
readr::write_csv(summary, opt$output_path_summary)
ggplot2::ggsave(opt$output_path_image, boxplot_image, width = 5, height = 2.5)
readr::write_csv(data, opt$output_path_clean)