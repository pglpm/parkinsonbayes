library(inferno)

parallel <- 3
learnt = 'output_learn_PBMC_NAD'

probabilities <- Pr(
    Y = data.frame(Tot.MDS.UPDRS.diff21 = (-30):30),
    X = data.frame(Sex = 'Female', TreatmentGroup = 'NR'),
    learnt = learnt
)

plot(probabilities)