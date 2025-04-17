.PHONY: all download

all: # Target name
	Rscript 01_load_data.R
	Rscript 02_methods.R
	Rscript 03_model.R
	Rscript 04_results.R

download: 
	Rscript 01_load_data.R