library('inferno')

parallel <- 3

learnt <- '_data/output_learn_NADPARK-significancy'


Y = data.frame(PBMCs.Me.Nam.4star.ratio21 = 1)

XNR <- expand.grid(Age = 60, TreatmentGroup = 'NR', stringsAsFactors = FALSE)
XPl <- expand.grid(Age = 60, TreatmentGroup = 'Placebo', stringsAsFactors = FALSE)

# Compute probabilities
probsNR <- tailPr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
                  quantiles = c(0.055, 0.945), lower.tail = lower.tail)
probsPl <- tailPr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
                  quantiles = c(0.055, 0.945), lower.tail = lower.tail)

print(paste0('Probs NR for ', name, ':'))
plot(probsNR)

print(paste0('Probs Pl for ', name, ':'))
plot(probsPl)
  
