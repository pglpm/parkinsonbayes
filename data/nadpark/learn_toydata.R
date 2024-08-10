### We now learn from the data.
###
### First we load the 'modelfreeinference' package.
### Check the README in
### https://github.com/pglpm/bayes_nonparametric_inference
### for installation instructions.

library('modelfreeinference')

seed <- 16

outputdir <- inferpopulation(
    data = 'toydata.csv',
    metadata = 'metatoydata.csv',
    outputdir = 'output_learn_toydata-1',
    output = 'directory',
    appendtimestamp = T,
    appendinfo = TRUE,
    nsamples = 3600,
    nchains = 8,
    parallel = 4,
    ## startupMCiterations = 1024,
    maxhours = 0/60,
    ## relerror = 0.02,
    ncheckpoints = NULL,
    cleanup = FALSE,
    ## miniter = 1200,
    prior = FALSE,
    showKtraces = TRUE,
    showAlphatraces = TRUE,
    seed = seed
)

cat('\nCalculating mutual information...\n')

mi <- mutualinfo(
    Y1names = c('diff.MDS.UPRS.III'),
    Y2names = c('Sex', 'Age',
        'Anamnestic.Loss.of.smell',
        'History.of.REM.Sleep.Behaviour.Disorder'),
    X = cbind(TreatmentGroup = 'NR'),
    mcoutput = outputdir,
    nsamples = 3600,
    parallel = 4
)

print(mi)

saveRDS(mi, file.path(outputdir, 'MI.rds'))

warnings()


cat('\nEnd\n')
