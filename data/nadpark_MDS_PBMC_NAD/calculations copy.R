library('inferno')
parallel <- 3
learnt = 'output_learn_MDS_PBMC_NAD'

Agevalues <- 40:80
sexValues <- c('Male', 'Female')
treatmentGroups <- c('NR', 'Placebo')
smellValues <- c('Yes', 'No')
sleepValues <- c('Yes', 'No')
diagnosisValues <- c('Established', 'Probable')

combinations <- expand.grid(MDS.ClinicalDiagnosisCriteria=diagnosisValues,
    stringsAsFactors = FALSE)

Y <- data.frame(PBMCs.Me.Nam.ratio21 = 2.5)

for(i in 1:nrow(combinations)){
    combo <- combinations[i, , drop = FALSE]

    ## We calculate probabilities separately for 'Placebo' and 'NR'
    ## A bit more expensive, but it allows us to use 'plot()' directly
    
    XNR <- expand.grid(Age = 40:80,
        TreatmentGroup = 'NR',
        MDS.ClinicalDiagnosisCriteria = combo$MDS.ClinicalDiagnosisCriteria,
        stringsAsFactors = FALSE)

    XPl <- expand.grid(Age = 40:80,
        TreatmentGroup = 'Placebo',
        MDS.ClinicalDiagnosisCriteria = combo$MDS.ClinicalDiagnosisCriteria,
        stringsAsFactors = FALSE)

    probsNR <- tailPr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
        quantiles=c(0.055, 0.945), lower.tail=FALSE)
    probsPl <- tailPr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
        quantiles=c(0.055, 0.945), lower.tail=FALSE)
    
    jpeg(file=file.path('Images/Diagnosis', paste0('subgroup_', i, '.png')), 
    height=5.8, width=8.3, res=300, units='in', quality=90)

    plot(probsNR, col=2, legend=FALSE,
        xlab='Age', ylab='P(PBMC-ratio <= 2.5)', ylim=c(0, 1))
    plot(probsPl, col=3, lty=2, legend=FALSE, add = TRUE)

    abline(h = 0.5, col = 'darkgrey', lwd = 1, lty = 2)

    legend('topright', legend=c('NR', 'Placebo'),
        col=c(2,3), lty=1:2, lwd=2, bty='n')

    legend('topleft', legend=c(paste0('Diagnosis: ', combo$MDS.ClinicalDiagnosisCriteria)
        ), col=1, bty='n')

    dev.off()
}