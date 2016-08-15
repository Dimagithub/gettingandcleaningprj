# Getting And Cleaning Data - Course Project

## Introduction

This repo contains my course project to [Coursera](https://www.coursera.org) ["Getting And Cleaning Data"](https://class.coursera.org/getdata-002) course that is part of [Data Science](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage) specialization.

Per requirements - only one script was created: `run_analysis.R`. The script contains all code necessary to generate required file. General flow is following:

1. Download UCI HAR zip file to `data` dir
2. Read data files
3. Transform data
4. Generate output data to a .tab file in a current folder

The `CodeBook.md` contains more details as well as the code in the script contains detailed remarks.


## Run from command line

1. Clone this repo
2. Run the script:

       $ Rscript run_analysis.R

3. Look for the result dataset in current folder `result.tab`

4. Read the file into R using following command:
`read.table("result.tab", header=TRUE)`
	   
## Open project with RStudio

Open RStudio project file `GettingAndCleaning.Rproj`.
