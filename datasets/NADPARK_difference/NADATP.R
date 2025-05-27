library('inferno')

parallel <- 3

learnt <- 'output_learn_NADPARK-difference'

Y <- data.frame(NAD.ATP.1star.diff = seq(-1, 1, by = 0.01))

XNR <- expand.grid(TreatmentGroup = 'NR')
XPl <- expand.grid(TreatmentGroup = 'Placebo')

probsNR <- Pr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
                quantiles = c(0.055, 0.945))
probsPl <- Pr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
                quantiles = c(0.055, 0.945))

ymax <- max(probsNR$quantiles, probsPl$quantiles, na.rm = TRUE)

plot(probsNR, legend = FALSE, 
    xlab = '(v2-v1)', ylim = c(0, ymax))
plot(probsPl, col=2, lty = 2, legend = FALSE, add = TRUE)

legend('topleft', legend = c('NR', 'Placebo'), col = 1:2, lty = 1:2)
