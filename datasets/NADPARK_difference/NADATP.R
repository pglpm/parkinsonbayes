library('inferno')

parallel <- 3

learnt <- 'output_learn_NADPARK-difference'

Y <- data.frame(NAD.ATP.1star.diff = 0:2)

XNR <- expand.grid(TreatmentGroup = 'NR')
XPl <- expand.grid(TreatmentGroup = 'Placebo')

probsNR <- Pr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
                quantiles = c(0.055, 0.945))
probsPl <- Pr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
                quantiles = c(0.055, 0.945))

plot(probsNR, legend = FALSE)
plot(probsPl, col = 2, lty = 2, legend = FALSE, add = TRUE)

legend('topleft', legend = c('NR', 'Placebo'), col = 1:2, lty = 1:2)
