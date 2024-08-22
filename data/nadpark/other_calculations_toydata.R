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
## a timestamp will be appended to this string
savedir <- 'output_learn_toydata-2'

## Call the main function for "learning"
## it will save everything in the directory outputdir
outputdir <- learn(
    data = 'toydata.csv',
    metadata = 'metatoydata.csv',
    outputdir = savedir,
    appendtimestamp = TRUE,
    output = 'directory',
    parallel = 8,
    seed = seed
)



cat('\nCalculating mutual information...\n')

miNR <- mutualinfo(
    Y1names = c('diff.MDS.UPRS.III'),
    Y2names = c('Sex', 'Age',
        'Anamnestic.Loss.of.smell',
        'History.of.REM.Sleep.Behaviour.Disorder'),
    X = cbind(TreatmentGroup = 'NR'),
    learnt = outputdir,
    nsamples = 3600,
    parallel = 8
)

print(miNR)

saveRDS(miNR, file.path(outputdir, 'MI_NR.rds'))

miPlacebo <- mutualinfo(
    Y1names = c('diff.MDS.UPRS.III'),
    Y2names = c('Sex', 'Age',
        'Anamnestic.Loss.of.smell',
        'History.of.REM.Sleep.Behaviour.Disorder'),
    X = cbind(TreatmentGroup = 'Placebo'),
    learnt = outputdir,
    nsamples = 3600,
    parallel = 8
)

print(miPlacebo)

saveRDS(miPlacebo, file.path(outputdir, 'MI_Placebo.rds'))

Ygrid <- cbind(diff.MDS.UPRS.III = (-132):132)

samplesNR <- Pr(
    Y = Ygrid,
    X = cbind(TreatmentGroup = 'NR'),
    learnt = outputdir,
    parallel = 4
)

saveRDS(samplesNR, file.path(outputdir, 'samples_NR.rds'))

samplesPlacebo <- Pr(
    Y = Ygrid,
    X = cbind(TreatmentGroup = 'Placebo'),
    learnt = outputdir,
    parallel = 8
)

saveRDS(samplesPlacebo, file.path(outputdir, 'samples_Placebo.rds'))

warnings()


cat('\nEnd\n')
