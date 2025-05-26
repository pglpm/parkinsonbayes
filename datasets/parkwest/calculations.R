library('inferno')
parallel <- 3
learntdir <- 'output_irene_data_3-vrt14_dat92_smp3600'
learnt <- file.path('_data', learntdir)

Y = data.frame(PFC1_percent = 85:100)
X = data.frame(Sex = 'F', Daily_cigarettes=0, Ethanol_units=0)

probs <- Pr(Y = Y, X = X, learnt = learnt, quantiles = c(0.055, 0.945),
            parallel = parallel)

plot(probs)