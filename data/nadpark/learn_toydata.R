### We now learn from the data.
###
### First we load the 'modelfreeinference' package.
### Check the README in
### https://github.com/pglpm/bayes_nonparametric_inference
### for installation instructions.

library('inferno')

seed <- 16

outputdir <- learn(
    data = 'toydata.csv',
    metadata = 'metatoydata.csv',
    outputdir = 'output_learn_toydata-3',
    output = 'directory',
    appendtimestamp = FALSE,
    appendinfo = FALSE,
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

stop()

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
