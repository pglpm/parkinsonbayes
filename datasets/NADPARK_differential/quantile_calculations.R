library('inferno')

parallel <- 3

learnt <- '_data/output_learn_NADPARK-differentinal'

Y_list <- list(
  '1star' = data.frame(NAD.ATP.1star.diff = (-0.2):0.5),
  '2star' = data.frame(GDF15.serum.2star.diff = (-870):13),
  '3star' = data.frame(Muscle.Me.NAAD.3star.diff = (-0.5):6.5),
  '4star' = data.frame(PBMCs.Me.Nam.4star.diff = (-1):2.1)
)

lower_tail_flags <- c('1star' = FALSE, '2star' = TRUE, '3star' = FALSE, '4star' = FALSE)

XNR <- expand.grid(TreatmentGroup = 'NR', stringsAsFactors = FALSE)
XPl <- expand.grid(TreatmentGroup = 'Placebo', stringsAsFactors = FALSE)

for (name in names(Y_list)) {
  Y <- Y_list[[name]]
  lower.tail <- lower_tail_flags[[name]]
  label <- name
  
  pdf(file = paste0('Images/', name, '_differential.pdf'),
        paper = 'special', height=148/25.4*1.5, width=210/25.4*1.5)

  probsNR <- tailPr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
                    quantiles = c(0.055, 0.945))
  probsPl <- tailPr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
                    quantiles = c(0.055, 0.945))

  plot(probsNR, legend = FALSE)
  plot(probsPl, col=2, lty = 2, legend = FALSE, add = TRUE)

  legend('topleft', legend = c(paste0(name, ': NR'), paste0(name, ': Placebo')), col = 1:2, lty = 1:2)
  dev.off()
}