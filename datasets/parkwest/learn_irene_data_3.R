### NADPark study
library('inferno')

## Set random-generator seed to reproduce results if repeated
seed <- 16

## How many parallel CPUs to use for the computation?
parallel <- 20

## Name of directory where to save what has been "learned"
## a timestamp may be appended to this string
dat <- 'irene_data_onlyPD.csv'
metadata <- 'meta_irene_data_3.csv'
outputdir <- 'output_irene_data_3'


## Call the main function for "learning"
## it will save everything in the directory outputdir
outputdir <- learn(
    data = dat,
    metadata = metadata,
    outputdir = outputdir,
    appendtimestamp = TRUE,
    appendinfo = TRUE,
    output = 'directory',
    parallel = parallel,
    ##
    ## nsamples = 12*60,
    ## nchains = parallel,
    ## maxhours = 0,
    ## startupMCiterations = 100,
    seed = seed
)
