library('inferno')

parallel <- 3

learnt <- '_data/output_learn_NADPARK-significancy'


Y <- data.frame(PBMCs.Me.Nam.4star.ratio21 = 1)

XNR <- expand.grid(Age = 40:80, TreatmentGroup = 'NR', Sex = 'Female', stringsAsFactors = FALSE)
XPl <- expand.grid(Age = 40:80, TreatmentGroup = 'Placebo', Sex = 'Female', stringsAsFactors = FALSE)

  
# Compute probabilities
probsNR <- tailPr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
                  quantiles = c(0.055, 0.945), lower.tail = FALSE)

probsPl <- tailPr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
                  quantiles = c(0.055, 0.945), lower.tail = FALSE)

jpeg('Images/first_plots.jpg', height=5.8, width=8.3, res=300, units='in', quality=90)

plot(probsNR, legend = FALSE, ylab = 'P(PBMCs.Me.Nam.ratio >= 1)')
plot(probsPl, col = 2, lty = 2, add = TRUE, legend = FALSE)

legend('topleft', legend = 'Sex: Female', bty = 'n')

legend('topright', legend=c('NR', 'Placebo'),
       col=1:2, lty=c(1,2), lwd=2, bty='n')

dev.off()