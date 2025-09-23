library('inferno')

parallel <- 3

learnt <- '_data/output_learn_NADPARK-significancy'

Agevalues <- 40:80
SexValues <- c('Male', 'Female')
TreatmentGroups <- c('NR', 'Placebo')
SmellValues <- c('Yes', 'No')
SleepValues <- c('Yes', 'No')
DiagnosisValues <- c('Established', 'Probable')

Y1star <- data.frame(NAD.ATP.1star.ratio21 = 1)
Y2star <- data.frame(GDF15.serum.2star.ratio = 1)
Y3star <- data.frame(Muscle.Me.NAAD.3star.ratio = 1)
Y4star <- data.frame(PBMCs.Me.Nam.4star.ratio21 = 1)

XNR <- expand.grid(Age = Agevalues,
    TreatmentGroup = 'NR',
    stringsAsFactors = FALSE)

XPl <- expand.grid(Age = Agevalues,
    TreatmentGroup = 'Placebo',
    stringsAsFactors = FALSE)

probsNR1star <- tailPr(Y = Y1star, X = XNR, learnt = learnt, parallel = parallel,
    quantiles=c(0.055, 0.945), lower.tail=FALSE)

probsNR2star <- tailPr(Y = Y2star, X = XNR, learnt = learnt, parallel = parallel,
    quantiles=c(0.055, 0.945))

probsNR3star <- tailPr(Y = Y3star, X = XNR, learnt = learnt, parallel = parallel,
    quantiles=c(0.055, 0.945), lower.tail = FALSE)

probsNR4star <- tailPr(Y = Y4star, X = XNR, learnt = learnt, parallel = parallel,
    quantiles=c(0.055, 0.945), lower.tail = FALSE)

  pdf(file = paste0('Images/Significancy_all.pdf'),
        paper = 'special', height=148/25.4*1.5, width=210/25.4*1.5)

plot(probsNR1star, col=1, legend=FALSE,
    xlab='Age', ylab='Probability of positive change', ylim=c(0, 1))

plot(probsNR2star, col=2, legend=FALSE, add = TRUE)

plot(probsNR3star, col=3, legend=FALSE, add = TRUE)

plot(probsNR4star, col=4, legend=FALSE, add = TRUE)

legend('topright', legend=c('NAD.ATP-1-star', 'GDF15-2-star', 'Muscle.Me.NAAD-3-star', 'PBMCs.Me-Nam-4-star'),
    col=1:4, lty=1, lwd=2, bty='n')

dev.off()