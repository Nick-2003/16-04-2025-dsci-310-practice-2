# 16-04-2025-dsci-310-practice-2

## Midterm:

- Name: Nicholas Tam
- Class: DSCI-310
- Year: 2024-25
- Term: W2
- Purpose: Final Practice 2

- `git branch`
- `git switch`
- `git log --oneline --graph --all`

## Tutorial 4:

`docker run --rm -e PASSWORD="password" -p 8787:8787 rocker/rstudio:4.4.2`

- `docker run`: Runs a command in a new container, pulling the image if needed and starting the container
- `--rm`: Remove upon completion
- `-e PASSWORD="pizza`: Set environment with the password "password"
- `-p 8787:8787`: Specify port
- `rocker/rstudio:4.4.2`: Image to run

## Tutorial 5:

### Creation of files

1. Create new file `list.sh` in VSCode
2. Run `bash list.sh` in terminal to return current directory’s list
3. Create `Dockerfile` in VSCode that uses `rocker/rstudio` container with version 4.4.2: `FROM rocker/rstudio:4.4.2`
4. Copy `list.sh` by command in `Dockerfile`: `COPY list.sh /home/rstudio/list.sh`
5. Set function to run the `list.sh` in the `Dockerfile` container: `RUN bash /home/rstudio/list.sh`

### How to run the script

1. Build the container named "dsci310practice1" in the root of repository: `docker build -t dsci310practice1 .`
2. Build the container named "dsci310practice1" within the "nt2103" dockeraccount: `docker build -t nt2103/dsci310practice1 .`
3. Run the "dsci310practice1" container: `docker run -p 8787:8787 -e PASSWORD="password" nt2103/dsci310practice1`
4. Go to rstudio: Open a browser and go to `localhost:8787`
5. Open a terminal tab
6. Run `bash /home/rstudio/list.sh`