library('inferno')

parallel = 3
learnt = 'output_learn_NAD-ratio'

X <- data.frame(TreatmentGroup = 'NR', Sex = 'male')
Y <- data.frame(visit_ratio = 0:2)

probabilities <- Pr(Y = Y, X = X, learnt = learnt, parallel = parallel)


flexiplot(x = as.matrix(Y$visit_ratio),
    y = probabilities$values,
    xlab = 'Visit ratio',
    ylab = 'probability',
    col = 3
)

plotquantiles(x = as.matrix(Y$visit_ratio),
    y = probabilities$quantiles[,1,],
    xlab = 'Visit ratio',
    ylab = 'probability',
    col = 2
)