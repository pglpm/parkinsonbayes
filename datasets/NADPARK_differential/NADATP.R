library(inferno)

parallel <- 3
learnt <- '_data/output_learn_NADPARK-differentinal'

Y <- data.frame(NAD.ATP.1star.diff = 0:1)
XNR <- data.frame(TreatmentGroup = 'NR')
XPl <- data.frame(TreatmentGroup = 'Placebo')

probsNR <- Pr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
                  quantiles = c(0.055, 0.945))
probsPl <- Pr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
                  quantiles = c(0.055, 0.945))

plot.new()
plot(probsNR, legend = FALSE, xlab="NAD/ATP V2-V1")
plot(probsPl, col=2, lty = 2, legend = FALSE, add = TRUE)

legend('topleft', legend = c('NR', 'Placebo'), col = 1:2, lty = 1:2)