library('inferno')

parallel = 3
learnt = 'output_learn_NAD-ratio'

X <- data.frame(TreatmentGroup = c('NR', 'placebo'), visit_ratio = 0.1:1)
Y <- data.frame(Age = 40:80)

probabilities <- Pr(Y = Y, X = X, learnt = learnt, parallel = parallel)


plotquantiles(x = as.matrix(Y$Age),
    y = probabilities$quantiles[,1,],
    xlab = 'diff.MDS.UPRS.III',
    ylab = 'probability of having a NAD ratio > 1',
    col = 1
)

plotquantiles(x = as.matrix(Y$Age),
    y = probabilities$quantiles[,2,],
    xlab = 'diff.MDS.UPRS.III',
    ylab = 'probability of having a NAD ratio > 1',
    col = 3,
    add = TRUE
)

flexiplot(x = as.matrix(Y$Age),
    y = probabilities$values[,1],
    xlab = 'diff.MDS.UPRS.III',
    ylab = 'probability of having a NAD ratio > 1',
    col = 1,
    add = TRUE
)

flexiplot(x = as.matrix(Y$Age),
    y = probabilities$values[,2],
    xlab = 'diff.MDS.UPRS.III',
    ylab = 'probability of having a NAD ratio > 1',
    col = 3,
    add = TRUE
)

legend('topright',
    legend = c('NR', 'placebo'),
    lty = 1, lwd = 2,
    col = 1:2,
    bty = 'n'
    )