FROM rocker/rstudio:4.4.2

COPY list.sh /home/rstudio/list.sh

RUN bash /home/rstudio/list.sh

RUN Rscript -e "install.packages('remotes')" # Double quotes for command itself, single quotes for within command 
RUN Rscript -e "remotes::install_version('renv', version='1.0.11')" # Install renv; since install_version is the same as install.packages; renv starts over or use lock file to instlal everything with renv 
RUN Rscript -e "remotes::install_version('cowsay', version='1.0.0')" # Installs cowsay with specifc version; since this is here, don't need to reactivate renv within R file 
RUN Rscript -e "remotes::install_version('rmarkdown', version='2.29', repos='https://cloud.r-project.org')"

COPY function.R /home/rstudio/function.R
COPY cowsaid.R /home/rstudio/cowsaid.R
COPY sampledoc.qmd /home/rstudio/sampledoc.qmd

# # Run the R script as rstudio user; has to be formatted like this to avoid JSONArgsRecommended warning; will run a RStudio instead if commented out; only 1 CMD instruction
# CMD ["Rscript", "/home/rstudio/function.R"] 
# CMD ["Rscript", "/home/rstudio/cowsaid.R"] 

# Start RStudio Server (this keeps the container running)
CMD ["/init"]