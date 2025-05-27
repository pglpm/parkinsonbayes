library('inferno')

parallel <- 3

learnt <- 'output_learn_NADPARK-difference'

Y_list <- list(
  'NAD-ATP' = data.frame(NAD.ATP.1star.diff = seq(-0.2,0.3, by = 0.01)),
  'GDF-15' = data.frame(GDF15.serum.2star.diff = (-870):910),
  'Muscle Me-NAAD' = data.frame(Muscle.Me.NAAD.3star.diff = seq(-1,2, by=0.01)),
  'PBMCs Me-Nam' = data.frame(PBMCs.Me.Nam.4star.diff = seq(-0.1, 2.1, by = 0.01))
)

XNR <- expand.grid(TreatmentGroup = 'NR', stringsAsFactors = FALSE)
XPl <- expand.grid(TreatmentGroup = 'Placebo', stringsAsFactors = FALSE)

for (name in names(Y_list)) {
  Y <- Y_list[[name]]
  label <- name
  
  pdf(file = paste0('Images/', name, '_differential.pdf'),
        paper = 'special', height=148/25.4*1.5, width=210/25.4*1.5)

  probsNR <- Pr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
                    quantiles = c(0.055, 0.945))
  probsPl <- Pr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
                    quantiles = c(0.055, 0.945))

  ymax <- max(probsNR$quantiles, probsPl$quantiles, na.rm = TRUE)

  plot(probsNR, legend = FALSE, 
       xlab = paste0(name, ' (v2-v1)'), ylim = c(0, ymax))
  plot(probsPl, col=2, lty = 2, legend = FALSE, add = TRUE)

  legend('topleft', legend = c(paste0(name, ': NR'), paste0(name, ': Placebo')), col = 1:2, lty = 1:2)
  dev.off()
}