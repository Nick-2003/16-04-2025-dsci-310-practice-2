library(readr)
library(tidyr)
library(palmerpenguins)

data <- penguins

# Initial cleaning: Remove missing values
data <- data %>% tidyr::drop_na()

readr::write_csv(data, "output/penguins.csv")