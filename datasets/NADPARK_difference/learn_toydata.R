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
parallel <- 3

## Name of directory where to save what has been "learned"
## a timestamp may be appended to this string
savedir <- 'output_learn_NADPARK-difference'

## Call the main function for "learning"
## it will save everything in the directory outputdir
outputdir <- learn(
    data = 'data_NADPARK-difference.csv',
    metadata = 'metadata_NADPARK-difference.csv',
    outputdir = savedir,
    appendtimestamp = FALSE,
    appendinfo = FALSE,
    output = 'directory',
    parallel = parallel,
    seed = seed
)
