library('inferno')

parallel = 3
learnt = 'output_learn_NAD-ratio'

Agevalues <- 40:80
sexValues <- c('male', 'female')
treatmentGroups <- c('NR', 'Placebo')
smellValues <- c('Yes', 'No')
sleepValues <- c('Yes', 'No')

for (smellValue in smellValues) {
  for (sleepValue in sleepValues) {
    X = data.frame(Age = 40:80,
                    Sex = 'male',
                    Anamnestic.Loss.of.smell = smellValue,
                    History.of.REM.Sleep.Behaviour.Disorder = sleepValue)
    Y = data.frame(visit_ratio = 1)

    probabilities <- tailPr(Y = Y, X = X, learnt = learnt, parallel = parallel)

    plottedprobs <- probabilities$values

    dim(plottedprobs) <- c(
    length(Agevalues), # rows
    length(plottedprobs)/length(Agevalues) # rest
)

    flexiplot(
        x = 40:80,
        y = plottedprobs,
        xlab = 'Age',
        ylab = 'visit_ratio <= 1'
    )
    legend('topright', 
           legend = c(paste('Loss of smell:', smellValue), paste('REM sleep:', sleepValue)), 
           col = 1:2)
    }
}
