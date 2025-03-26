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
X <- expand.grid(Age = Agevalues,
                TreatmentGroup = 'NR',
                Sex='Male',
                MDS.ClinicalDiagnosisCriteria = 'Established',
                AnamnesticLossSmell = 'Yes',
                History.REM.SleepBehaviourDisorder = 'Yes',
                stringsAsFactors = FALSE
)

probabilities <- tailPr(Y = Y, X = X, learnt = learnt, 
                        parallel = parallel, 
                            lower.tail = FALSE)

plottedprobs <- probabilities$values

dim(plottedprobs) <- c(
length(Agevalues), # rows
length(plottedprobs)/length(Agevalues) # rest
)

plot(probabilities)