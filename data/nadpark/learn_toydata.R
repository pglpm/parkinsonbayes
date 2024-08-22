### We now learn from the data.
###
### First we load the 'inferno' package.
### Check the README in
### https://github.com/pglpm/inferno
### for installation instructions.
library('inferno')

## Set random-generator seed to reproduce results if repeated
seed <- 16

## How many parallel CPUs to use for the computation?
parallel <- 4

## Name of directory where to save what has been "learned"
## a timestamp may be appended to this string
savedir <- 'output_learn_toydata-3'

## Call the main function for "learning"
## it will save everything in the directory outputdir
outputdir <- learn(
    data = 'toydata.csv',
    metadata = 'metatoydata.csv',
    outputdir = savedir,
    appendtimestamp = FALSE,
    output = 'directory',
    parallel = 8,
    seed = seed
)
