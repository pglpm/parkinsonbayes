library('inferno')

parallel <- 3

learnt <- '_data/output_learn_NADPARK-significancy'
Agevalues <- 40:80
SexValues <- c('Male', 'Female')
TreatmentGroups <- c('NR', 'Placebo')
SmellValues <- c('Yes', 'No')
SleepValues <- c('Yes', 'No')
DiagnosisValues <- c('Established', 'Probable')

ranks <- list(Y1star <- data.frame(NAD.ATP.1star.ratio21 = 1),
Y2star <- data.frame(GDF15.serum.2star.ratio = 1),
Y3star <- data.frame(Muscle.Me.NAAD.3star.ratio = 1),
Y4star <- data.frame(PBMCs.Me.Nam.4star.ratio21 = 1))

XNR <- expand.grid(Age = Agevalues,
    TreatmentGroup = 'NR',
    stringsAsFactors = FALSE)

XPl <- expand.grid(Age = Agevalues,
    TreatmentGroup = 'Placebo',
    stringsAsFactors = FALSE)

for(value in ranks) {
    probsNR <- tailPr(Y = value, X = XNR, learnt = learnt, parallel = parallel,
        quantiles=c(0.055, 0.945), lower.tail=FALSE)
        
    probsPl <- tailPr(Y = value, X = XPl, learnt = learnt, parallel = parallel,
        quantiles=c(0.055, 0.945), lower.tail=FALSE)

    jpeg(file=file.path('Images', paste0('significancy_', names(value), '.png')),
        height=5.8, width=8.3, res=300, units='in', quality=90)
    
    plot(probsNR, col=1,
    xlab='Age', ylab='Probability of positive change', ylim=c(0, 1))
    
    plot(probsPl, col=2, add = TRUE)
    
    dev.off()
}
