library('inferno')
parallel <- 3
learnt <- 'output_learn_NAD-ratio'

Agevalues <- 40:80
sexValues <- c('male', 'female')
treatmentGroups <- c('NR', 'Placebo')
smellValues <- c('Yes', 'No')
sleepValues <- c('Yes', 'No')

## Create a data frame of all possible combinations, that is, subgroups
combinations <- expand.grid(Sex=sexValues,
    Anamnestic.Loss.of.smell=smellValues,
    History.of.REM.Sleep.Behaviour.Disorder=sleepValues,
    stringsAsFactors = FALSE)

## Y is the same for each combination, so we define it outside the for-loop
Y <- data.frame(visit_ratio = 1)

for(i in 1:nrow(combinations)){
    combo <- combinations[i, ]

    ## We calculate probabilities separately for 'Placebo' and 'NR'
    ## A bit more expensive, but it allows us to use 'plot()' directly
    
    XNR <- expand.grid(Age = 40:80,
        TreatmentGroup = 'NR',
        Sex = combo$Sex,
        Anamnestic.Loss.of.smell = combo$Anamnestic.Loss.of.smell,
        History.of.REM.Sleep.Behaviour.Disorder = combo$History.of.REM.Sleep.Behaviour.Disorder,
        stringsAsFactors = FALSE)

    XPl <- expand.grid(Age = 40:80,
        TreatmentGroup = 'Placebo',
        Sex = combo$Sex,
        Anamnestic.Loss.of.smell = combo$Anamnestic.Loss.of.smell,
        History.of.REM.Sleep.Behaviour.Disorder = combo$History.of.REM.Sleep.Behaviour.Disorder,
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
        paste0('SmellLoss: ', combo$Anamnestic.Loss.of.smell),
        paste0('SleepDisorder: ', combo$History.of.REM.Sleep.Behaviour.Disorder)
        ), col=1, bty='n')

    dev.off()
}

