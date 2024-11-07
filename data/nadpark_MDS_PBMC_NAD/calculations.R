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

Y <- data.frame(PBMCs.Me.Nam.ratio21 = 1)

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
        quantiles=c(0.055, 0.945), lower.tail=FALSE)
    probsPl <- tailPr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
        quantiles=c(0.055, 0.945), lower.tail=FALSE)
    
    jpeg(file=file.path('Images', paste0('subgroup_', i, '.png')), 
    height=5.8, width=8.3, res=300, units='in', quality=90)

    plot(probsNR, col=2, legend=FALSE,
        xlab='Age', ylab='P(PBMCs Me-Nam-ratio <= 1)', ylim=c(0, 1))
    plot(probsPl, col=3, lty=2, legend=FALSE, add = TRUE)

    abline(h = 0.5, col = '#ffd900', lwd = 2.5, lty = 2)

    legend('topright', legend=c('NR', 'Placebo'),
        col=c(2,3), lty=1:2, lwd=2, bty='n')

    legend('topleft', legend=c(paste0('Sex: ',combo$Sex),
        paste0('Diagnosis: ', combo$MDS.ClinicalDiagnosisCriteria),
        paste0('SmellLoss: ', combo$AnamnesticLossSmell),
        paste0('SleepDisorder: ', combo$History.REM.SleepBehaviourDisorder)
        ), col=1, bty='n')

    dev.off()
}