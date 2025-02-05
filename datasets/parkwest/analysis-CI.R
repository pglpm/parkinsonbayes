#### Exploration of results about NAD

library('inferno')

## How many parallel cores for the calculations
parallel <- 8

## Name of directory where the "learning" has been saved
learnt <- 'output_toy_data_0_CI-250131T111110-vrt13_dat116_smp3600'

## Consider several variate domains
valuelist <- list(
    Group = c('Ctrl', 'PD'),
    PD_subtype_AR_TD = c("Ctrl","AR","Mixed","TD"),
    PD_subtype_PIGD_TD = c("Ctrl","PIGD","Mixed","TD"),
    PFC1_percent = 75:100,
    SNpc_percent = 15:100,
    Sex = c('F', 'M'),
    PMI = 1:131,
    DV200 = 65:100,
    RIN = 1:10
)

qtiles <- c(0.055, 0.945)


## Plot PFC1 for Ctrl and PD
vPFC <- data.frame(PFC1_percent = valuelist$PFC1_percent)
vSN <- data.frame(SNpc_percent = valuelist$SNpc_percent)
vAR <- data.frame(PD_subtype_AR_TD = valuelist$PD_subtype_AR_TD)
vGD <- data.frame(PD_subtype_PIGD_TD = valuelist$PD_subtype_PIGD_TD)

mypdf('CI_PDtype_plots')
probs <- Pr(Y = vAR, X = vPFC, priorY = TRUE, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(probs, variability = 'quantiles', ylim=c(0,1), lty=1)

probs <- Pr(Y = vGD, X = vPFC, priorY = TRUE, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(probs, variability = 'quantiles', ylim=c(0,1), lty=1)



probs <- Pr(Y = vAR, X = vSN, priorY = TRUE, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(probs, variability = 'quantiles', ylim=c(0,1), lty=1)

probs <- Pr(Y = vGD, X = vSN, priorY = TRUE, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(probs, variability = 'quantiles', ylim=c(0,1), lty=1)
dev.off()



## probs <- Pr(Y = vAR, X = vPFC, priorY = NULL, learnt = learnt, quantiles = qtiles,
##     parallel = parallel)
## ##
## plot(probs, variability = 'quantiles', ylim=c(0,1), lty=1)



Xar <- data.frame(PD_subtype_AR_TD = valuelist$PD_subtype_AR_TD)

pCI_Group <- Pr(Y = Y, X = Xar, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(pCI_Group, variability = 'quantiles')

pCI_Group <- Pr(Y = Xar, X = Y, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(pCI_Group, variability = 'quantiles')


pCI_Group <- Pr(Y = Y, X = Xar, priorY = TRUE, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(pCI_Group, variability = 'quantiles')


Xpi <- data.frame(PD_subtype_PIGD_TD = valuelist$PD_subtype_PIGD_TD)
Xpc <- data.frame(PFC1_percent = valuelist$PFC1_percent)







probs <- Pr(Y = vAR, X = vPFC, priorY = NULL, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##

par(mfrow=c(2,1))
plot(probs, variability = 'samples', ylim=c(0,1), lty=1)
plot(probs, variability = 'quantiles', ylim=c(0,1), lty=1)






par(mfrow=c(1,1))
plot(probs, variability = 'samples', ylim=c(0,1), lty=1)
plot(probs, variability = 'quantiles', ylim=c(0,1), lty=1)


probs <- Pr(Y = vAR, X = vPFC, priorY = NULL, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(probs, variability = 'quantiles', ylim=c(0,1))

probs <- Pr(Y = vPFC, X = vAR, priorY = NULL, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(probs, variability = 'quantiles')




X <- data.frame(Group= valuelist$Group)

pCI_Group <- Pr(Y = Y, X = Xar, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(pCI_Group, variability = 'quantiles')


mi_Group_CI <- mutualinfo(Y1names = 'PD_subtype_AR_TD', Y2names = 'PFC1_percent', learnt = learnt, parallel = parallel)
mi_Group_CI

mi_Group_CI <- mutualinfo(Y1names = 'PD_subtype_PIGD_TD', Y2names = 'PFC1_percent', learnt = learnt, parallel = parallel)
mi_Group_CI










pCI_Group <- Pr(Y = Y, X = Xpi, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(pCI_Group, variability = 'quantiles')




pGroup_CI <- Pr(Y = X, X = Y, learnt = learnt, quantiles = qtiles,
    parallel = parallel)
##
plot(pGroup_CI, variability = 'quantiles', ylim=c(0,1))

mi_Group_CI <- mutualinfo(Y1names = 'Group', Y2names = 'PFC1_percent', learnt = learnt, parallel = parallel)

Y <- data.frame(PBMCs.Me.Nam.ratio21 = 1)


combinations <- expand.grid(
    Sex = sexValues,
    MDS.ClinicalDiagnosisCriteria = diagnValues,
    AnamnesticLossSmell = smellValues,
    History.REM.SleepBehaviourDisorder = remValues,
    stringsAsFactors = FALSE)


toplot <- c('MDS.ClinicalDiagnosisCriteria',
    'AnamnesticLossSmell',
    'History.REM.SleepBehaviourDisorder',
    'Sex')

lower.tail <- FALSE
if(lower.tail){
    addpdf <- 'low'
    addylab <- '<'
}else{
    addpdf <- 'hi'
    addylab <- '>'
}
mypdf(paste0('__testcheck50', addpdf))
for(vrt in toplot){
    for(val in valuelist[[vrt]]){
        X <- setNames(expand.grid('Placebo', valuelist$Age, val,
            stringsAsFactors = FALSE),
            c('TreatmentGroup', 'Age', vrt))
        tprobPl <- tailPr(Y=Y, X=X, learnt=learnt, quantiles=qtiles,
            parallel=parallel, lower.tail=lower.tail)
        ##
        X <- setNames(expand.grid('NR', valuelist$Age, val,
            stringsAsFactors = FALSE),
            c('TreatmentGroup', 'Age', vrt))
        tprobNR <- tailPr(Y=Y, X=X, learnt=learnt, quantiles=qtiles,
            parallel=parallel, lower.tail=lower.tail)
        ##
        plot(tprobPl, legend=FALSE, col=3, lty=2,
            xlab='Age', ylab=paste0('P(PBMCs.Me.Nam.ratio21 ', addylab, ' 1)'), ylim=0:1)
        plot(tprobNR, legend=FALSE, col=2, add = TRUE)
        abline(h=0.5, col=5, lty=2, lwd=2)
        ##
        mylegend('topleft', legend=paste0(vrt,'=',val), lty=NA, pch=NA,
            cex=0.75)
        mylegend('topright', legend=c('Placebo','NR'),
            lty=c(2,1), pch=NA, lwd=3, col=c(3,2),
            cex=0.75)
    }
}
##
##
X <- data.frame(
    Age=valuelist$Age,
    TreatmentGroup='Placebo',
    Sex='Female',
    MDS.ClinicalDiagnosisCriteria='Probable',
    ## Sex='Male',
    ## MDS.ClinicalDiagnosisCriteria='Established',
    AnamnesticLossSmell='Yes',
    History.REM.SleepBehaviourDisorder='Yes')
tprobPl <- tailPr(Y=Y, X=X, learnt=learnt, quantiles=qtiles,
            parallel=parallel, lower.tail=lower.tail)
##
X <- data.frame(
    Age=valuelist$Age,
    TreatmentGroup='NR',
    Sex='Female',
    MDS.ClinicalDiagnosisCriteria='Probable',
    ## Sex='Male',
    ## MDS.ClinicalDiagnosisCriteria='Established',
    AnamnesticLossSmell='Yes',
    History.REM.SleepBehaviourDisorder='Yes')
tprobNR <- tailPr(Y=Y, X=X, learnt=learnt, quantiles=qtiles,
    parallel=parallel, lower.tail=lower.tail)
##
plot(tprobPl, legend=FALSE, col=3, lty=2,
    xlab='Age', ylab=paste0('P(PBMCs.Me.Nam.ratio21 ', addylab, ' 1)'), ylim=0:1)
plot(tprobNR, legend=FALSE, col=2, add = TRUE)
abline(h=0.5, col=5, lty=2, lwd=2)
##
mylegend('topleft', legend=paste0('combined'), lty=NA, pch=NA,
    cex=0.75)
mylegend('topright', legend=c('Placebo','NR'),
    lty=c(2,1), pch=NA, lwd=3, col=c(3,2),
    cex=0.75)
##
dev.off()

