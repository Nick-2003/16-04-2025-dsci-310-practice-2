.PHONY: all clean

all: 
	make clean
	make index.html

clean:
	rm -rf output/*
	rm -rf data/*
	rm -rf docs/*

index.html: work/data/raw/penguins.csv \
	work/data/processed/penguins_clean.csv \
	work/data/processed/train_data.csv \
	work/data/processed/test_data.csv \
	work/output/penguin_fit.RDS \
	work/output/conf_mat.RDS \
	work/output/func_outputs.csv \
	work/reports/t6-quarto_copy.html \
	work/reports/t6-quarto_copy.pdf
	cp work/reports/t6-quarto_copy.html work/docs/index.html

# For 01_load_data.R
work/data/raw/penguins.csv: work/src/01_load_data.R
	Rscript work/src/01_load_data.R \
	--output_path=work/data/raw/penguins.csv

# For 02_methods.R
work/data/processed/penguins_clean.csv: work/src/02_methods.R work/data/raw/penguins.csv
	Rscript work/src/02_methods.R \
	--input_path=work/data/raw/penguins.csv \
	--output_path_summary=work/output/summary_stats.csv \
	--output_path_image=work/output/boxplot.png \
	--output_path_clean=work/data/processed/penguins_clean.csv

# For 03_model.R
work/data/train_data.csv work/data/processed/test_data.csv work/output/penguin_fit.RDS: work/src/03_model.R work/data/processed/penguins_clean.csv
	Rscript work/src/03_model.R \
	--input_path=work/data/processed/penguins_clean.csv \
	--output_path_train=work/data/train_data.csv \
	--output_path_test=work/data/processed/test_data.csv \
	--output_path_model=work/output/penguin_fit.RDS

# For 04_results.R
work/output/conf_mat.RDS: work/src/04_results.R work/data/train_data.csv work/data/processed/test_data.csv work/output/penguin_fit.RDS
	Rscript work/src/04_results.R \
	--input_path_train=work/data/train_data.csv \
	--input_path_test=work/data/processed/test_data.csv \
	--input_path_model=work/output/penguin_fit.RDS \
	--output_path=work/output/conf_mat.RDS

# For 05_package.R
work/output/func_outputs.csv: work/src/05_package.R
	Rscript work/src/05_package.R \
	--output_path=work/output/func_outputs.csv

# render quarto report in HTML and PDF using work/output work/reports/diabetes_classification_report.qmd
work/reports/t6-quarto_copy.html: work/output work/reports/t6-quarto_copy.qmd
	quarto render work/reports/t6-quarto_copy.qmd --to html

work/reports/t6-quarto_copy.pdf: work/output work/reports/t6-quarto_copy.qmd
	quarto render work/reports/t6-quarto_copy.qmd --to pdf