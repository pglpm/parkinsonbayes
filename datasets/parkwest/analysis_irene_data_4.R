#### Parkwest: Exploration of dependence on drinking and smoking

library('inferno')

## How many parallel cores for the calculations
parallel <- 8

## Name of directory where 'learnt' has been saved
learntdir <- 'output_irene_data_3-vrt14_dat92_smp3600'
learnt <- file.path('_data', learntdir)

metadata <- read.csv(file.path('_data', learntdir, 'metadata.csv'),
    na.strings = '', stringsAsFactors = FALSE,
    colClasses=c(
        name = 'character',
        type = 'character',
        domainmin = 'numeric',
        domainmax = 'numeric',
        datastep = 'numeric',
        minincluded = 'character',
        maxincluded = 'character'
    ))

## Variates & values
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

## quantiles to show
qtiles <- c(0.055, 0.945)

## function to subset an object of class probability
## (this will be included in the software later on)
subsetpr <- function(probj, vrt, vrtval){
    sel <- probj$X[[vrt]] == vrtval
    probj$values <- probj$values[, sel, drop = FALSE]
    probj$quantiles <- probj$quantiles[ , sel, , drop = FALSE]
    probj$samples <- probj$samples[ , sel, , drop = FALSE]
    probj$X[[vrt]] <- NULL
    probj$X <- probj$X[sel, , drop = FALSE]
    probj
}

## utility function for printing pdf # not used here
pdf2 <- function(file, ...){
    pdf(file = paste0(sub('.pdf$', '', file), '.pdf'),
        paper = 'special', height=148/25.4*1.5, width=210/25.4*1.5, ...)
}

Y <- as.data.frame(list(PFC1_percent = vrts$PFC1_percent))

Xall <- expand.grid(
    ## = vrts$,
    Sex = vrts$Sex,
    Daily_cigarettes = vrts$Daily_cigarettes,
    ## PD_subtype_AR_TD = vrts$PD_subtype_AR_TD,
    ## Age_of_death = vrts$Age_of_death,
    ## Ethanol_units = vrts$Ethanol_units,
    ##
    stringsAsFactors = FALSE)


probs <- Pr(Y = Y, X = Xall, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
saveRDS(object = probs, file = 'probs_noEthanol.rds')
