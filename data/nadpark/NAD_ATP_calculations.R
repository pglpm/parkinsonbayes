library('inferno')

parallel = 3

learnt = 'output_learn_NAD-ratio'

Y <- data.frame(TreatmentGroup = 'NR', Sex = 'male', Age = 40:80)
X <- data.frame(visit_ratio = 0:2)

probabilities <- Pr(Y = Y, X = X, learnt = learnt, parallel = parallel)

flexiplot(
    x = X$visit_ratio,
    y = probabilities$values,
    xlab = 'NAD visit ratio',
    ylab = 'probability'
)