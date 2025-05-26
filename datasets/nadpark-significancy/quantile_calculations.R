library('inferno')

parallel <- 3

learnt <- '_data/output_learn_NADPARK-significancy'

Y_list <- list(
  '1star' = data.frame(NAD.ATP.1star.ratio21 = 1),
  '2star' = data.frame(GDF15.serum.2star.ratio = 1),
  '3star' = data.frame(Muscle.Me.NAAD.3star.ratio = 1),
  '4star' = data.frame(PBMCs.Me.Nam.4star.ratio21 = 1)
)

lower_tail_flags <- c('1star' = FALSE, '2star' = TRUE, '3star' = FALSE, '4star' = FALSE)

XNR <- expand.grid(TreatmentGroup = 'NR', stringsAsFactors = FALSE)
XPl <- expand.grid(TreatmentGroup = 'Placebo', stringsAsFactors = FALSE)


for (name in names(Y_list)) {
  Y <- Y_list[[name]]
  lower.tail <- lower_tail_flags[[name]]
  label <- display_names[[name]]
  
  # Compute probabilities
  probsNR <- tailPr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
                    quantiles = c(0.055, 0.945), lower.tail = lower.tail)
  probsPl <- tailPr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
                    quantiles = c(0.055, 0.945), lower.tail = lower.tail)

  print(paste0('Probs NR for ', name, ':'))
  plot(probsNR)

  print(paste0('Probs Pl for ', name, ':'))
  plot(probsPl)
  
}