library(inferno)

parallel <- 3
learnt = 'output_learn_PBMC_NAD'

probabilities <- tailPr(
    Y = data.frame(PBMCs.Me.Nam.ratio21 = 1),
    X = data.frame(Sex = 'Female', TreatmentGroup = 'NR', Age = 60),
    learnt = learnt, lower.tail = FALSE, quantiles = c(0.055, 0.945),
    parallel = parallel)


plot(probabilities)