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
    nchains = 60,
    parallel = 8,
    ## startupMCiterations = 1024,
    maxhours = +Inf,
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

miNR <- mutualinfo(
    Y1names = c('diff.MDS.UPRS.III'),
    Y2names = c('Sex', 'Age',
        'Anamnestic.Loss.of.smell',
        'History.of.REM.Sleep.Behaviour.Disorder'),
    X = cbind(TreatmentGroup = 'NR'),
    mcoutput = outputdir,
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
    mcoutput = outputdir,
    nsamples = 3600,
    parallel = 8
)

print(miPlacebo)

saveRDS(miPlacebo, file.path(outputdir, 'MI_Placebo.rds'))

warnings()


cat('\nEnd\n')
