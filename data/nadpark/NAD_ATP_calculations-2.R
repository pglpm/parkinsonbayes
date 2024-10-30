library('inferno')
parallell = 3
learnt = 'output_learn_NAD-ratio'

Agevalues <- 40:80
sexValues <- c('male', 'female')
treatmentGroups <- c('NR', 'Placebo')
smellValues <- c('Yes', 'No')
sleepValues <- c('Yes', 'No')

Y <- data.frame(visit_ratio = 1)
X <- expand.grid(Age = 40:80,
                TreatmentGroup = treatmentGroups,
                Anamnestic.Loss.of.smell = 'Yes',
                History.of.REM.Sleep.Behaviour.Disorder = 'Yes')

probabilities <- tailPr(Y = Y, X = X, learnt = learnt, parallel = parallel)

plottedprobs <- probabilities$values

dim(plottedprobs) <- c(
    length(Agevalues), # rows
    length(plottedprobs)/length(Agevalues) # rest
)

plotquantiles(
    x = 40:80,
    y = probabilities$quantiles,
    xlab = 'Age',
    ylab = 'visit_ratio <= 1',
    xlim = c(40, 80), ylim = c(0, 1)
)

flexiplot(
    x = 40:80,
    y = plottedprobs,
    xlab = 'Age',
    ylab = 'visit_ratio <= 1',
    xlim = c(40, 80), ylim = c(0, 1),
    add = TRUE
)

legend('topright', 
        legend = c(('Yes, NR'), ('Yes, placebo')), 
        col = 1:2)