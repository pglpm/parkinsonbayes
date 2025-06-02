library('inferno')
parallel = 3
learnt = 'output_learn_PBMC_NAD'

Agevalues <- 40:80
sexValues <- c('male', 'female')
treatmentGroups <- c('NR', 'Placebo')
smellValues <- c('Yes', 'No')
sleepValues <- c('Yes', 'No')
diagnosisValues <- c('Established', 'Probable')

Y <- data.frame(PBMCs.Me.Nam.ratio21 = 1)
XNR <- expand.grid(Age = Agevalues,
                TreatmentGroup = 'NR',
                Sex='Female'
)

XNR <- expand.grid(Age = Agevalues,
                TreatmentGroup = 'Placebo',
                Sex='Female'
)

probsNR <- tailPr(Y = Y, X = XNR, learnt = learnt, 
                        parallel = parallel, 
                            lower.tail = FALSE)
probsNR <- tailPr(Y = Y, X = XNR, learnt = learnt, 
                        parallel = parallel, 
                            lower.tail = FALSE)

plot(probsNR)