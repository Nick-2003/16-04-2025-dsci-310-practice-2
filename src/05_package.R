"This script tests the package functionalities

Usage: src/05-package.R --output_path=<output_path>

Options:
--output_path=<output_path>
" -> doc

library(docopt)
library(regexcite20250416)

opt <- docopt::docopt(doc)

# Explicit namespace use
calls <- c("regexcite20250416::is_leap(2000)", 
           "regexcite20250416::is_leap(1900)", 
           "regexcite20250416::temp_conv(41, 'F', 'C')")

# Evaluate each safely
outputs <- sapply(calls, function(call) {
  tryCatch({
    eval(parse(text = call))
  }, error = function(e) {
    paste("Error:", e$message)
  })
})

# Create dataframe
func_outputs <- data.frame(
  Function = calls,
  Output = outputs,
  stringsAsFactors = FALSE
)

# Save to CSV
readr::write_csv(func_outputs, opt$output_path)