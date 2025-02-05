#### Exploration of results about NAD

library('inferno')

## How many parallel cores for the calculations
parallel <- 8

## Name of directory where 'learnt' has been saved
learnt <- file.path('_data','irene_data_onlyPD-vrt22_dat92_smp3600')
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
    PD_subtype_AR_TD = c("AR","Mixed","TD"),
    PD_subtype_PIGD_TD = c("PIGD","Mixed","TD"),
    PFC1_percent = 75:100,
    SNpc_percent = 15:100,
    Sex = c('F', 'M'),
    PMI = 1:131,
    DV200 = 65:100,
    RIN = 1:10
)

## quantiles to show
qtiles <- c(0.055, 0.945)

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
        probs[[percent]][[pdgroup]] <- Pr(Y = Y, X = X, priorY = TRUE,
            learnt = learnt, quantiles = qtiles, parallel = parallel)
    }
}

## Plot all four combinations
for(percent in c('PFC1_percent', 'SNpc_percent')){
    for(pdgroup in c('PD_subtype_AR_TD', 'PD_subtype_PIGD_TD')){
        ##
        Y <- as.data.frame(vrts[pdgroup])
        X <- as.data.frame(vrts[percent])
        prob <- probs[[percent]][[pdgroup]]
        ##
        pdf2(file = paste0(pdgroup, '_', percent,'_onlyPD'))
        par(mfrow = c(2, 2), mai=rep(0.5,4), oma=rep(1,4), mar=c(4,4,0,0))
        for(i in 2:nrow(Y)){
            for(j in 1:(nrow(Y)-1)){
                if(i <= j){
                    plot.new()
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
        }
        dev.off()
    }
}

#### Sex subgroups
## Calculate probs for all four plots
probssex <- list()
for(sex in vrts$Sex){
    for(percent in c('PFC1_percent', 'SNpc_percent')){
        for(pdgroup in c('PD_subtype_AR_TD', 'PD_subtype_PIGD_TD')){
            Y <- as.data.frame(vrts[pdgroup])
            X <- as.data.frame(c( vrts[percent], list(Sex = sex)))
            ##
            probssex[[percent]][[pdgroup]][[sex]] <- Pr(Y = Y, X = X, priorY = TRUE,
                learnt = learnt, quantiles = qtiles, parallel = parallel)
        }
    }
}

## Plot all four combinations
for(percent in c('PFC1_percent', 'SNpc_percent')){
    for(pdgroup in c('PD_subtype_AR_TD', 'PD_subtype_PIGD_TD')){
        ##
        Y <- as.data.frame(vrts[pdgroup])
        X <- as.data.frame(vrts[percent])
        pdf2(file = paste0(pdgroup, '_', percent, '_onlyPD_MF'))
        for(sex in vrts$Sex){
            prob <- probssex[[percent]][[pdgroup]][[sex]]
            ##
            par(mfrow = c(2, 2), mai=rep(0.5,4), oma=rep(1,4), mar=c(4,4,0,0))
            for(i in 2:nrow(Y)){
                for(j in 1:(nrow(Y)-1)){
                    if(i <= j){
                        plot.new()
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
        }
        dev.off()
    }
}


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
