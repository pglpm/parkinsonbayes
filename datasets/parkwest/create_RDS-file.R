library(inferno)

parallel <- 3

learntdir <- 'output_irene_data_3-vrt14_dat92_smp3600'
learnt <- file.path('_data', learntdir)

vrts <- list(
    ## Group = c('Ctrl', 'PD'),
    PD_subtype_AR_TD = c("AR","Mixed","TD"),
    PD_subtype_PIGD_TD = c("PIGD","Mixed","TD"),
    PFC1_percent = 75:100,
    SNpc_percent = 15:100,
    Sex = c('F', 'M'),
    PMI = 1:131,
    DV200 = 65:100,
    RIN = 1:10,
    Daily_cigarettes = 0:35,
    Ethanol_units = 0:16,
    Age_of_death = 46:100
)
qtiles <- c(0.055, 0.945)

Y <- as.data.frame(list(PFC1_percent = vrts$PFC1_percent))

Xall <- expand.grid(
    ## = vrts$,
    Sex = "F",
    Daily_cigarettes = vrts$Daily_cigarettes,
    #PD_subtype_AR_TD = vrts$PD_subtype_AR_TD,
    ## Age_of_death = vrts$Age_of_death,
    Ethanol_units = vrts$Ethanol_units,
    stringsAsFactors = FALSE)

probs <- Pr(Y = Xall, X = Y, learnt = learnt, quantiles = qtiles,
            parallel = parallel)
saveRDS(object = probs, file = 'probs_F_reverse.rds')