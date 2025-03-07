#### Exploration of results about NAD

library('inferno')

## How many parallel cores for the calculations
parallel <- 8

################################################################
#### Preliminary exploration with controls
################################################################

learnt <- file.path('_data','irene_data_ctrl_PD-vrt13_dat116_smp3600')
vrts <- list(
    Group = c('Ctrl', 'PD'),
    PD_subtype_AR_TD = c("Ctrl","AR","TD"),
    PD_subtype_PIGD_TD = c("Ctrl","PIGD","TD"),
    PFC1_percent = 75:100,
    SNpc_percent = 75:100,
    Sex = c('F', 'M'),
    PMI = 1:131,
    DV200 = 65:100,
    RIN = 1:10
)

data <- read.csv('_data/irene_data_onlyPD.csv',
                    na.strings = '', stringsAsFactors = FALSE, tryLogical = FALSE)

Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(vrts['Group'])
## testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
## plot(testp, ylim=c(0,0.05))
plot(testp2, ylim=c(0,1))


Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(vrts['PD_subtype_AR_TD'])
## testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
## plot(testp, ylim=c(0,0.15))
plot(testp2, ylim=c(0,1))

Y <- as.data.frame(vrts['SNpc_percent'])
X <- as.data.frame(vrts['PD_subtype_AR_TD'])
## testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
## plot(testp, ylim=c(0,0.15))
plot(testp2, ylim=c(0,1))



################################################################
#### Prior only PD
################################################################

## Name of directory where 'learnt' has been saved
learnt <- file.path('_data','output_irene_nodata_3-250216T104643-vrt14_dat92_smp3600')
metadata <- read.csv('meta_irene_data_onlyPD.csv',
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
    Cohort = c('NTB', 'PW'),
    PD_subtype_AR_TD = c("AR","TD"),
    PD_subtype_PIGD_TD = c("PIGD","TD"),
    PFC1_percent = 75:100,
    SNpc_percent = 75:100,
    Sex = c('F', 'M'),
    PMI = 1:131,
    DV200 = 65:100,
    RIN = 1:10,
    Dementia = c('no', 'yes')
)

## quantiles to show
qtiles <- c(0.055, 0.945) # 89%
qtiles <- c(0.25, 0.75) # 50%


Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(vrts['PD_subtype_AR_TD'])
## testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
## plot(testp, ylim=c(0,0.15))
plot(testp2, ylim=c(0,1))

################################################################
#### only PD 5 datapoints
################################################################

## Name of directory where 'learnt' has been saved
learnt <- file.path('_data','output_irene_5data_3-250216T105232-vrt14_dat5_smp3600')
metadata <- read.csv('meta_irene_data_onlyPD.csv',
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
    Cohort = c('NTB', 'PW'),
    PD_subtype_AR_TD = c("AR","TD"),
    PD_subtype_PIGD_TD = c("PIGD","TD"),
    PFC1_percent = 75:100,
    SNpc_percent = 75:100,
    Sex = c('F', 'M'),
    PMI = 1:131,
    DV200 = 65:100,
    RIN = 1:10,
    Dementia = c('no', 'yes')
)

## quantiles to show
qtiles <- c(0.055, 0.945) # 89%
qtiles <- c(0.25, 0.75) # 50%


Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(vrts['PD_subtype_AR_TD'])
## testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
## plot(testp, ylim=c(0,0.15))
plot(testp2, ylim=c(0,1))



################################################################
#### Only PD
################################################################


## Name of directory where 'learnt' has been saved
learnt <- file.path('_data','output_irene_data_3-vrt14_dat92_smp3600')
metadata <- read.csv('meta_irene_data_onlyPD.csv',
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
    Cohort = c('NTB', 'PW'),
    PD_subtype_AR_TD = c("AR","TD"),
    PD_subtype_PIGD_TD = c("PIGD","TD"),
    PFC1_percent = 75:100,
    SNpc_percent = 75:100,
    Sex = c('F', 'M'),
    PMI = 1:131,
    DV200 = 65:100,
    RIN = 1:10,
    Dementia = c('no', 'yes')
)


## quantiles to show
qtiles <- c(0.055, 0.945) # 89%
qtiles <- c(0.25, 0.75) # 50%


Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(vrts['PD_subtype_AR_TD'])
## testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
## plot(testp, ylim=c(0,0.15))
plot(testp2, ylim=c(0,1))


Y <- as.data.frame(vrts['SNpc_percent'])
X <- as.data.frame(vrts['PD_subtype_AR_TD'])
## testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
## plot(testp, ylim=c(0,0.15))
plot(testp2, ylim=c(0,1))


Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(vrts['PD_subtype_PIGD_TD'])
## testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
## plot(testp, ylim=c(0,0.15))
plot(testp2, ylim=c(0,1))



Y <- as.data.frame(c(vrts['PFC1_percent'], list(Sex='F')))
X <- as.data.frame(vrts['PD_subtype_AR_TD'])
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
Y <- as.data.frame(c(vrts['PFC1_percent'], list(Sex='M')))
X <- as.data.frame(vrts['PD_subtype_AR_TD'])
testp2b <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
## plot(testp, ylim=c(0,0.05))
plot(testp2, ylim=c(0,1),legend=FALSE, cex.axis=2, cex.lab=2)
plot(testp2b, ylim=c(0,1), col=c(4,7), add=TRUE, legend=FALSE)
legend('topright',
    legend=c('AR, within F', 'TD, within F', 'AR, within M', 'TD, within M'),
    col=c(1:2,4,7), lty=1:2, lwd=3, bty='n', cex=2)



################################################################
################################################################



Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(c(vrts['PD_subtype_AR_TD'], list(Dementia='yes')))
testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
plot(testp, ylim=c(0,0.05))
plot(testp2, ylim=c(0,1))

Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(c(vrts['Dementia'], list(PD_subtype_AR_TD = 'AR')))
testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
plot(testp, ylim=c(0,0.05))
plot(testp2, ylim=c(0,1))

Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(c(vrts['PD_subtype_PIGD_TD'], list(Dementia='no')))
testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
plot(testp, ylim=c(0,0.05))
plot(testp2, ylim=c(0,1))

Y <- as.data.frame(vrts['PFC1_percent'])
X <- as.data.frame(c(vrts['Dementia'], list(PD_subtype_AR_TD = 'AR')))
testp <- Pr(Y=Y, X=X, learnt=learnt, quantiles=qtiles, parallel=parallel)
testp2 <- Pr(Y=X, X=Y, learnt=learnt, quantiles=qtiles, parallel=parallel)
##
plot(testp, ylim=c(0,0.05))
plot(testp2, ylim=c(0,1))




## utility function for pdf
pdf2 <- function(file, ...){
    pdf(file = paste0(sub('.pdf$', '', file), '.pdf'),
        paper = 'special', height=148/25.4*1.5, width=210/25.4*1.5, ...)
}

#### Plot PFC1_percent and SNpc_percent
#### for different PD_subtype_AR_TD and PD_subtype_PIGD_TD


## Calculate probs for all four plots
probs <- list()
for(percent in c('PFC1_percent', 'SNpc_percent')){
    for(pdgroup in c('PD_subtype_AR_TD', 'PD_subtype_PIGD_TD')){
        Y <- as.data.frame(vrts[pdgroup])
        X <- as.data.frame(vrts[percent])
        ##
        probs[[percent]][[pdgroup]] <- Pr(Y = Y, X = X, # priorY = TRUE,
            learnt = learnt, quantiles = qtiles, parallel = parallel)
    }
}

## Plot all four combinations
pdf2(file = paste0('CIpercent_vs_phenotype_v3'))
for(percent in c('PFC1_percent', 'SNpc_percent')){
    for(pdgroup in c('PD_subtype_AR_TD', 'PD_subtype_PIGD_TD')){
        ##
        Y <- as.data.frame(vrts[pdgroup])
        X <- as.data.frame(vrts[percent])
        prob <- probs[[percent]][[pdgroup]]
        ##
        par(mfrow = c(2, 2), mai=rep(0.5,4), oma=rep(1,4), mar=c(4,4,2,0))
        for(i in 2:nrow(Y)){
            for(j in 1:(nrow(Y)-1)){
                if(i <= j){
                    plot(prob, variability = 'quantiles', ylim=c(0,1),
                        lty=1:3, col=1:3,
                        ylab=paste0('Pr(', pdgroup, '|', percent, ')'))
                    title('-- all together --', line=-2)
                    ## plot.new()
                } else if(i > j){
                    prob0 <- prob
                    prob0$values <- prob0$values[c(i,j), , drop=FALSE]
                    prob0$quantiles <- prob0$quantiles[c(i,j), , , drop=FALSE]
                    prob0$Y <- Y[c(i,j), , drop=FALSE]
                    ##
                    plot(prob0, variability = 'quantiles', ylim=c(0,1),
                        lty=c(i,j), col=c(i,j),
                        ylab=paste0('Pr(', pdgroup, '|', percent, ')'))
                }
            }
            title(bquote('probability of: '~italic(.(pdgroup))~'   given: '~italic(.(percent))),
                line = -1, outer = TRUE)
        }
    }
}
dev.off()

#### Sex subgroups
## Calculate probs for all four plots
probssex <- list()
for(sex in vrts$Sex){
    for(percent in c('PFC1_percent', 'SNpc_percent')){
        for(pdgroup in c('PD_subtype_AR_TD', 'PD_subtype_PIGD_TD')){
            Y <- as.data.frame(vrts[pdgroup])
            X <- as.data.frame(c( vrts[percent], list(Sex = sex)))
            ##
            probssex[[percent]][[pdgroup]][[sex]] <- Pr(Y = Y, X = X, #priorY = TRUE,
                learnt = learnt, quantiles = qtiles, parallel = parallel)
        }
    }
}

## Plot all four combinations
pdf2(file = paste0('CIpercent_vs_phenotype_Sexsubgroups'))
for(percent in c('PFC1_percent', 'SNpc_percent')){
    for(pdgroup in c('PD_subtype_AR_TD', 'PD_subtype_PIGD_TD')){
        ##
        Y <- as.data.frame(vrts[pdgroup])
        X <- as.data.frame(vrts[percent])
        for(sex in vrts$Sex){
            prob <- probssex[[percent]][[pdgroup]][[sex]]
            ##
            par(mfrow = c(2, 2), mai=rep(0.5,4), oma=rep(1,4), mar=c(4,4,2,0))
            for(i in 2:nrow(Y)){
                for(j in 1:(nrow(Y)-1)){
                    if(i <= j){
                    plot(prob, variability = 'quantiles', ylim=c(0,1),
                        lty=1:3, col=1:3,
                        ylab=paste0('Pr(', pdgroup, '|', percent, ')'))
                    title('-- all together --', line=-2)
                        ## plot.new()
                    } else if(i > j){
                        prob0 <- prob
                        prob0$values <- prob0$values[c(i,j), , drop=FALSE]
                        prob0$quantiles <- prob0$quantiles[c(i,j), , , drop=FALSE]
                        prob0$Y <- Y[c(i,j), , drop=FALSE]
                        ##
                        plot(prob0, variability = 'quantiles', ylim=c(0,1),
                            lty=c(i,j), col=c(i,j),
                            ylab=paste0('Pr(', pdgroup, '|', percent, ')'))
                        text(x=100, y=0.8, labels=paste0('Sex: ', sex))
                    }
                }
            }
            ## title(paste0('probability of: ', pdgroup, '   given: ', percent,
            ##     '   for subgroup: ', sex),
            title(bquote('probability of: '~italic(.(pdgroup))~'   given: '~italic(.(percent))~'   for subgroup: '~italic(.(sex))),
                line = -1, outer = TRUE)
        }
    }
}
dev.off()


#### Calculation of mutual information
#### Requires a roundabout way in order to correct for base rate of PDgroups

## One PD group
percent <- c('PFC1_percent', 'SNpc_percent')
pdgroup <- 'PD_subtype_AR_TD'
Y <- as.data.frame(vrts[pdgroup])

mutinf <- list()
for(i in 1:nrow(Y)){
mutinf[[i]] <- mutualinfo(Y1names=percent, Y2names=NULL, X=Y[i,,drop=F],
    learnt=learnt, parallel=parallel)
}
mutinf0 <- mutualinfo(Y1names=percent, Y2names=NULL, X=NULL,
    learnt=learnt, parallel=parallel)

association <- c(value = 0, error = 0)
for(i in 1:nrow(Y)){
    association <- association - c(1, -1) * mutinf[[i]]$En1^c(1,2)
}
association <- (association/(nrow(Y)^c(1,2)) + mutinf0$En1^c(1,2))^c(1,0.5)
association
##     value     error 
## 0.0719059 0.0425991 
sqrt(1-4^(-association))
## 0.308019

## Other PD group
pdgroup <- 'PD_subtype_PIGD_TD'
Y <- as.data.frame(vrts[pdgroup])

mutinf <- list()
for(i in 1:nrow(Y)){
mutinf[[i]] <- mutualinfo(Y1names=percent, Y2names=NULL, X=Y[i,,drop=F],
    learnt=learnt, parallel=parallel)
}

association <- c(value = 0, error = 0)
for(i in 1:nrow(Y)){
    association <- association - c(1, -1) * mutinf[[i]]$En1^c(1,2)
}
association <- (association/(nrow(Y)^c(1,2)) + mutinf0$En1^c(1,2))^c(1,0.5)
association
##     value     error 
## 0.0719059 0.0425991 
sqrt(1-4^(-association))
## 0.308019
