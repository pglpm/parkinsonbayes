library('inferno')
parallel <- 3
learnt = 'output_learn_MDS_PBMC_NAD'

Agevalues <- 40:80
sexValues <- c('Male', 'Female')
treatmentGroups <- c('NR', 'Placebo')
smellValues <- c('Yes', 'No')
sleepValues <- c('Yes', 'No')
diagnosisValues <- c('Established', 'Probable')

combinations <- expand.grid(Sex=sexValues,
    MDS.ClinicalDiagnosisCriteria=diagnosisValues,
    AnamnesticLossSmell=smellValues,
    History.REM.SleepBehaviourDisorder=sleepValues,
    stringsAsFactors = FALSE)

Y <- data.frame(NAD.ATP.ratio21 = 1)

for(i in 1:nrow(combinations)){
    combo <- combinations[i, ]

    ## We calculate probabilities separately for 'Placebo' and 'NR'
    ## A bit more expensive, but it allows us to use 'plot()' directly
    
    XNR <- expand.grid(Age = 40:80,
        TreatmentGroup = 'NR',
        Sex = combo$Sex,
        MDS.ClinicalDiagnosisCriteria = combo$MDS.ClinicalDiagnosisCriteria,
        AnamnesticLossSmell = combo$AnamnesticLossSmell,
        History.REM.SleepBehaviourDisorder = combo$History.REM.SleepBehaviourDisorder,
        stringsAsFactors = FALSE)

    XPl <- expand.grid(Age = 40:80,
        TreatmentGroup = 'Placebo',
        Sex = combo$Sex,
        MDS.ClinicalDiagnosisCriteria = combo$MDS.ClinicalDiagnosisCriteria,
        AnamnesticLossSmell = combo$AnamnesticLossSmell,
        History.REM.SleepBehaviourDisorder = combo$History.REM.SleepBehaviourDisorder,
        stringsAsFactors = FALSE)

    probsNR <- tailPr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
        quantiles=c(0.055, 0.945))
    probsPl <- tailPr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
        quantiles=c(0.055, 0.945))

    pdf(file=file.path('Images', paste0('subgroup_', i, '.pdf')),
    paper='special', height=148/25.4, width = 210/25.4)
    
    plot(probsPl, col=3, legend=FALSE,
        xlab='Age', ylab='P(NADratio <= 1)')
    plot(probsNR, col=2, lty=2, legend=FALSE, add = TRUE)

    legend('topright', legend=c('Placebo', 'NR'),
        col=c(3,2), lty=1:2, lwd=2, bty='n')

    legend('topleft', legend=c(paste0('Sex: ',combo$Sex),
        paste0('Diagnosis: ', combo$MDS.ClinicalDiagnosisCriteria),
        paste0('SmellLoss: ', combo$AnamnesticLossSmell),
        paste0('SleepDisorder: ', combo$History.REM.SleepBehaviourDisorder)
        ), col=1, bty='n')

    dev.off()
}