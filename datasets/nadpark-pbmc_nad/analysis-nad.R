#### Exploration of results about NAD

library('inferno')

## How many parallel cores for the calculations
parallel <- 4

## Name of directory where the "learning" has been saved
learntdir <- 'output_learn_MDS_PBMC_NAD'

## Consider several variate domains
agevalues <- 31:60 # as an example
treatvalues <- c('NR', 'Placebo')
sexvalues <- c('Female', 'Male')
smellvalues <- c('No', 'Yes')
remvalues <- c('No', 'Yes')
mdsvalues <- 15:80
mdsdiffvalues <- (-20):20
nadvalues <- seq(0.1, 0.7, by = 0.01)
nadratiovalues <- seq(0.1, 2.5, by = 0.05)
pbmcvalues <- seq(0.01, 2.5, by = 0.01)
pbmcratiovalues <- seq(0.1, 8, by = 0.05)

## Check difference in PBMC distribution between visits, for various subgroups

##########################################################################
#### Examine NAD ratio between visits, only TreatmentGroup
##########################################################################


## Treatment & Sex, create all combinations
Xall <- expand.grid(TreatmentGroup = treatvalues,
    stringsAsFactors = FALSE)
##
probsNADr <- Pr(
    Y = data.frame(NAD.ATP.ratio21 = nadratiovalues),
    X = Xall,
    learnt = learntdir,
    nsamples = 'all',
    parallel = parallel
)
##
Xfemale <- expand.grid(TreatmentGroup = treatvalues, Sex = 'Female',
    stringsAsFactors = FALSE)
##
probsNADrfemale <- Pr(
    Y = data.frame(NAD.ATP.ratio21 = nadratiovalues),
    X = Xfemale,
    learnt = learntdir,
    nsamples = 'all',
    parallel = parallel
)
##
Xmale <- expand.grid(TreatmentGroup = treatvalues, Sex = 'Male',
    stringsAsFactors = FALSE)
##
probsNADrmale <- Pr(
    Y = data.frame(NAD.ATP.ratio21 = nadratiovalues),
    X = Xmale,
    learnt = learntdir,
    nsamples = 'all',
    parallel = parallel
)

## Plot
## find max value to plot
ymax <- max(probsNADr$quantiles, probsNADrfemale$quantiles, probsNADrmale$quantiles)
mypdf('NADratio_comparisons', portrait = FALSE)
plot(probsNADr, ylim = c(0, ymax))
plot(probsNADrfemale, ylim = c(0, ymax))
plot(probsNADrmale, ylim = c(0, ymax))
dev.off()


##########################################################################
#### Examine NAD ratio between visits, only TreatmentGroup
##########################################################################


## Treatment & Sex, create all combinations
Xall <- expand.grid(TreatmentGroup = treatvalues,
    stringsAsFactors = FALSE)
##
probsPBMCr <- Pr(
    Y = data.frame(PBMCs.Me.Nam.ratio21 = pbmcratiovalues),
    X = Xall,
    learnt = learntdir,
    nsamples = 'all',
    parallel = parallel
)
##
Xfemale <- expand.grid(TreatmentGroup = treatvalues, Sex = 'Female',
    stringsAsFactors = FALSE)
##
probsPBMCrfemale <- Pr(
    Y = data.frame(PBMCs.Me.Nam.ratio21 = pbmcratiovalues),
    X = Xfemale,
    learnt = learntdir,
    nsamples = 'all',
    parallel = parallel
)
##
Xmale <- expand.grid(TreatmentGroup = treatvalues, Sex = 'Male',
    stringsAsFactors = FALSE)
##
probsPBMCrmale <- Pr(
    Y = data.frame(PBMCs.Me.Nam.ratio21 = pbmcratiovalues),
    X = Xmale,
    learnt = learntdir,
    nsamples = 'all',
    parallel = parallel
)

## Plot
## find max value to plot
ymax <- max(probsPBMCr$quantiles, probsPBMCrfemale$quantiles, probsPBMCrmale$quantiles)
mypdf('PBMCratio_comparisons', portrait = FALSE)
plot(probsPBMCr, ylim = c(0, ymax))
plot(probsPBMCrfemale, ylim = c(0, ymax))
plot(probsPBMCrmale, ylim = c(0, ymax))
dev.off()


######
#### Some checks about the probabilty of getting out of quantiles
######

with(probsNADr,
    {
        outf <- sapply(seq_len(dim(samples)[3]),
            function(i){
                sum(samples[, 1, i] > quantiles[, 1, 4] |
                        samples[, 1, i] < quantiles[, 1, 1]) /
                    dim(samples)[1]
            })
        print(summary(outf))
        mean(outf)
    })
##
with(probsNADr,
    {
        outf <- sapply(seq_len(dim(samples)[3]),
            function(i){
                sum(samples[, 2, i] > quantiles[, 2, 4] |
                        samples[, 2, i] < quantiles[, 2, 1]) /
                    dim(samples)[1]
            })
        print(summary(outf))
        mean(outf)
    })
##
with(probsPBMCr,
    {
        outf <- sapply(seq_len(dim(samples)[3]),
            function(i){
                sum(samples[, 1, i] > quantiles[, 1, 4] |
                        samples[, 1, i] < quantiles[, 1, 1]) /
                    dim(samples)[1]
            })
        print(summary(outf))
        mean(outf)
    })
##
with(probsPBMCr,
    {
        outf <- sapply(seq_len(dim(samples)[3]),
            function(i){
                sum(samples[, 2, i] > quantiles[, 2, 4] |
                        samples[, 2, i] < quantiles[, 2, 1]) /
                    dim(samples)[1]
            })
        print(summary(outf))
        mean(outf)
    })
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0000  0.0204  0.0816  0.1100  0.1633  0.7959 
## [1] 0.11
## >  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0000  0.0204  0.0816  0.1100  0.1633  0.7755 
## [1] 0.11
## >  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0000  0.0000  0.0377  0.1100  0.1572  0.9245 
## [1] 0.11
## >  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0000  0.0000  0.0314  0.1100  0.1384  0.9182 
## [1] 0.11


with(probsNADr,
    {
        outf <- sapply(seq_len(dim(samples)[3]),
            function(i){
                sum(samples[, 1, i] > quantiles[, 1, 3] |
                        samples[, 1, i] < quantiles[, 1, 2]) /
                    dim(samples)[1]
            })
        print(summary(outf))
        mean(outf)
    })
##
with(probsNADr,
    {
        outf <- sapply(seq_len(dim(samples)[3]),
            function(i){
                sum(samples[, 2, i] > quantiles[, 2, 3] |
                        samples[, 2, i] < quantiles[, 2, 2]) /
                    dim(samples)[1]
            })
        print(summary(outf))
        mean(outf)
    })
##
with(probsPBMCr,
    {
        outf <- sapply(seq_len(dim(samples)[3]),
            function(i){
                sum(samples[, 1, i] > quantiles[, 1, 3] |
                        samples[, 1, i] < quantiles[, 1, 2]) /
                    dim(samples)[1]
            })
        print(summary(outf))
        mean(outf)
    })
##
with(probsPBMCr,
    {
        outf <- sapply(seq_len(dim(samples)[3]),
            function(i){
                sum(samples[, 2, i] > quantiles[, 2, 3] |
                        samples[, 2, i] < quantiles[, 2, 2]) /
                    dim(samples)[1]
            })
        print(summary(outf))
        mean(outf)
    })
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.388   0.510   0.500   0.633   0.959 
## [1] 0.5
## >  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0204  0.3673  0.5102  0.5000  0.6327  0.9388 
## [1] 0.5
## >  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.296   0.528   0.500   0.704   0.987 
## [1] 0.5
## >  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.270   0.509   0.500   0.736   0.981 
## [1] 0.5




##########################################################################
##########################################################################
##########################################################################
##########################################################################
#### OLD STUFF






probsNADr <- tailPr(
    Y = data.frame(NAD.ATP.ratio21 = 1),
    X = X,
    nsamples = 'all',
    lower.tail = TRUE,
    learnt = learntdir,
    parallel = parallel
)


tailprobsTSPBMC <- tailPr(
    Y = data.frame(PBMCs.Me.Nam.ratio21 = 1),
    X = X,
    nsamples = 'all',
    lower.tail = FALSE,
    learnt = learntdir,
    parallel = parallel
)

cbind(X, data.frame(pr=c(tailprobsTSPBMC$values),
    uncl = c(tailprobsTSPBMC$quantiles[, , 1]),
    unch = c(tailprobsTSPBMC$quantiles[, , 4])
    ))
##   TreatmentGroup    Sex       pr     uncl     unch
## 1             NR Female 0.803520 0.651432 0.921040
## 2        Placebo Female 0.673499 0.495248 0.830257
## 3             NR   Male 0.787842 0.655015 0.898149
## 4        Placebo   Male 0.657306 0.490693 0.802246
myhist(tailprobsTSPBMC$samples[,
    X$Sex == 'Male' & X$TreatmentGroup == 'NR', ], col = 3, plot=T, border=3)
myhist(tailprobsTSPBMC$samples[,
    X$Sex == 'Male' & X$TreatmentGroup == 'Placebo', ], plot=T, add = T, col=2, border=2)

ls()



## Treatment & Sex, create all combinations
X <- expand.grid(TreatmentGroup = treatvalues, Sex = sexvalues,
    stringsAsFactors = FALSE)
##
probsTSPBMC <- Pr(
    Y = data.frame(PBMCs.Me.Nam.ratio21 = pbmcratiovalues),
    X = X,
    learnt = learntdir,
    parallel = parallel
)

tailprobsTSPBMC <- tailPr(
    Y = data.frame(PBMCs.Me.Nam.ratio21 = 1),
    X = X,
    nsamples = 'all',
    lower.tail = FALSE,
    learnt = learntdir,
    parallel = parallel
)

cbind(X, data.frame(pr=c(tailprobsTSPBMC$values),
    uncl = c(tailprobsTSPBMC$quantiles[, , 1]),
    unch = c(tailprobsTSPBMC$quantiles[, , 4])
    ))
##   TreatmentGroup    Sex       pr     uncl     unch
## 1             NR Female 0.803520 0.651432 0.921040
## 2        Placebo Female 0.673499 0.495248 0.830257
## 3             NR   Male 0.787842 0.655015 0.898149
## 4        Placebo   Male 0.657306 0.490693 0.802246
myhist(tailprobsTSPBMC$samples[,
    X$Sex == 'Male' & X$TreatmentGroup == 'NR', ], col = 3, plot=T, border=3)
myhist(tailprobsTSPBMC$samples[,
    X$Sex == 'Male' & X$TreatmentGroup == 'Placebo', ], plot=T, add = T, col=2, border=2)










## Plot
## find max value to plot
ymax <- max(probsTSPBMC$quantiles[, X$Sex == 'Male', ])
mypdf('PBMCratio_comparisons_male', portrait = FALSE)
par(mgp = c(1, 0, 0),
    oma = c(0.5, 0.5, 0.5, 0.5),
    mar = c(2, 2, 0, 0)) # space for one row of text at ticks and to separate plots
## Plot distributions for Male, NR
plotquantiles(x = pbmcratiovalues,
    y = probsTSPBMC$quantiles[, X$Sex == 'Male' & X$TreatmentGroup == 'NR',
        c(1, 4)],
    col = 2, ylim = c(0, ymax),
    xlab = 'NAD ratio visit2/visit1', ylab = 'probability')
plotquantiles(x = pbmcratiovalues,
    y = probsTSPBMC$quantiles[, X$Sex == 'Male' & X$TreatmentGroup == 'Placebo',
        c(1, 4)],
    col = 3,
    add = TRUE)
flexiplot(x = pbmcratiovalues,
    y = probsTSPBMC$values[, X$Sex == 'Male' & X$TreatmentGroup == 'NR'],
    col = 2, lty = 1, lwd = 3,
    add = TRUE)
flexiplot(x = pbmcratiovalues,
    y = probsTSPBMC$values[, X$Sex == 'Male' & X$TreatmentGroup == 'Placebo'],
    col = 3, lty = 2, lwd = 3,
    add = TRUE)
legend('topright', bty = 'n',
    col = c(2, 3), lty = 1:2, lwd = 3,
    legend = c('NR, Male', 'Placebo, Male'))
dev.off()


## Treatment & Sex, create all combinations

X <- expand.grid(TreatmentGroup = treatvalues, Sex = sexvalues,
    stringsAsFactors = FALSE)
##
probsTS1 <- Pr(
    Y = data.frame(v1.NAD = nad1values),
    X = X,
    learnt = learntdir,
    parallel = parallel
)
##
probsTS2 <- Pr(
    Y = data.frame(v2.NAD = nad2values),
    X = X,
    learnt = learntdir,
    parallel = parallel
)


#### Stack plots
ymax <- max(probsTS1$quantiles[, X$Sex == 'Male', ],
    probsTS2$quantiles[, X$Sex == 'Male', ])
mypdf('NADvisits_comparisons_male', portrait = TRUE)
par(mfrow = c(2, 1), mgp = c(1, 0, 0),
    oma = c(0.5, 0.5, 0.5, 0.5),
    mar = c(2, 2, 0, 0)) # space for one row of text at ticks and to separate plots
## Plot distributions for Male, NR
plotquantiles(x = nad1values,
    y = probsTS1$quantiles[, X$Sex == 'Male' & X$TreatmentGroup == 'NR', c(1, 4)],
    col = 2, ylim = c(0, ymax),
    xlab = NA, xaxt = 'n', ylab = 'probability')
plotquantiles(x = nad2values,
    y = probsTS2$quantiles[, X$Sex == 'Male' & X$TreatmentGroup == 'NR', c(1, 4)],
    col = 6,
    add = TRUE)
flexiplot(x = nad1values,
    y = probsTS1$values[, X$Sex == 'Male' & X$TreatmentGroup == 'NR'],
    col = 2, lty = 1, lwd = 3,
    add = TRUE)
flexiplot(x = nad2values,
    y = probsTS2$values[, X$Sex == 'Male' & X$TreatmentGroup == 'NR'],
    col = 6, lty = 2, lwd = 3,
    add = TRUE)
legend('topright', bty = 'n',
    col = c(2, 6), lty = 1:2, lwd = 3,
    legend = c('NR, Male, Visit 1', 'Male, NR, Visit 2'))
##
## Plot distributions for Male, Placebo
plotquantiles(x = nad1values,
    y = probsTS1$quantiles[, X$Sex == 'Male' & X$TreatmentGroup == 'Placebo',
        c(1, 4)],
    col = 7, ylim = c(0, ymax),
    xlab = 'NAD', ylab = 'probability')
plotquantiles(x = nad2values,
    y = probsTS2$quantiles[, X$Sex == 'Male' & X$TreatmentGroup == 'Placebo',
        c(1, 4)],
    col = 3,
    add = TRUE)
flexiplot(x = nad1values,
    y = probsTS1$values[, X$Sex == 'Male' & X$TreatmentGroup == 'Placebo'],
    col = 7, lty = 1, lwd = 3,
    add = TRUE)
flexiplot(x = nad2values,
    y = probsTS2$values[, X$Sex == 'Male' & X$TreatmentGroup == 'Placebo'],
    col = 3, lty = 2, lwd = 3,
    add = TRUE)
legend('topright', bty = 'n',
    col = c(7, 3), lty = 1:2, lwd = 3,
    legend = c('Placebo, Male, Visit 1', 'Male, Placebo, Visit 2'))
dev.off()


##########################################################################
#### Examine NAD ratio between visits
##########################################################################

## Name of directory where the "learning" has been saved
learntdir <- 'output_learn_nadratio-1'

## Consider several variate domains
nadratiovalues <- seq(0.1, 2.5, by = 0.005)

## Check difference in NAD distribution between visits, for various subgroups

## Treatment & Sex, create all combinations

X <- expand.grid(TreatmentGroup = treatvalues, Sex = sexvalues,
    stringsAsFactors = FALSE)
##
probsTSr <- Pr(
    Y = data.frame(ratio21.NAD = nadratiovalues),
    X = X,
    learnt = learntdir,
    parallel = parallel
)

#### Stack plots
## find max value to plot
ymax <- max(probsTSr$quantiles[, X$Sex == 'Male', ])
mypdf('NADratio_comparisons_male', portrait = FALSE)
par(mgp = c(1, 0, 0),
    oma = c(0.5, 0.5, 0.5, 0.5),
    mar = c(2, 2, 0, 0)) # space for one row of text at ticks and to separate plots
## Plot distributions for Male, NR
plotquantiles(x = nadratiovalues,
    y = probsTSr$quantiles[, X$Sex == 'Male' & X$TreatmentGroup == 'NR',
        c(1, 4)],
    col = 2, ylim = c(0, ymax),
    xlab = 'NAD ratio visit2/visit1', ylab = 'probability')
plotquantiles(x = nadratiovalues,
    y = probsTSr$quantiles[, X$Sex == 'Male' & X$TreatmentGroup == 'Placebo',
        c(1, 4)],
    col = 3,
    add = TRUE)
flexiplot(x = nadratiovalues,
    y = probsTSr$values[, X$Sex == 'Male' & X$TreatmentGroup == 'NR'],
    col = 2, lty = 1, lwd = 3,
    add = TRUE)
flexiplot(x = nadratiovalues,
    y = probsTSr$values[, X$Sex == 'Male' & X$TreatmentGroup == 'Placebo'],
    col = 3, lty = 2, lwd = 3,
    add = TRUE)
legend('topright', bty = 'n',
    col = c(2, 3), lty = 1:2, lwd = 3,
    legend = c('NR, Male', 'Placebo, Male'))
dev.off()








##########################################
#### Female
##########################################



#### Stack plots
ymax <- max(probsTS1$quantiles[, X$Sex == 'Female', ],
    probsTS2$quantiles[, X$Sex == 'Female', ])
mypdf('NADvisits_comparisons_female', portrait = TRUE)
par(mfrow = c(2, 1), mgp = c(1, 0, 0),
    oma = c(0.5, 0.5, 0.5, 0.5),
    mar = c(2, 2, 0, 0)) # space for one row of text at ticks and to separate plots
## Plot distributions for Female, NR
plotquantiles(x = nad1values,
    y = probsTS1$quantiles[, X$Sex == 'Female' & X$TreatmentGroup == 'NR', c(1, 4)],
    col = 2, ylim = c(0, ymax),
    xlab = NA, xaxt = 'n', ylab = 'probability')
plotquantiles(x = nad2values,
    y = probsTS2$quantiles[, X$Sex == 'Female' & X$TreatmentGroup == 'NR', c(1, 4)],
    col = 6,
    add = TRUE)
flexiplot(x = nad1values,
    y = probsTS1$values[, X$Sex == 'Female' & X$TreatmentGroup == 'NR'],
    col = 2, lty = 1, lwd = 3,
    add = TRUE)
flexiplot(x = nad2values,
    y = probsTS2$values[, X$Sex == 'Female' & X$TreatmentGroup == 'NR'],
    col = 6, lty = 2, lwd = 3,
    add = TRUE)
legend('topright', bty = 'n',
    col = c(2, 6), lty = 1:2, lwd = 3,
    legend = c('NR, Female, Visit 1', 'Female, NR, Visit 2'))
##
## Plot distributions for Female, Placebo
plotquantiles(x = nad1values,
    y = probsTS1$quantiles[, X$Sex == 'Female' & X$TreatmentGroup == 'Placebo',
        c(1, 4)],
    col = 7, ylim = c(0, ymax),
    xlab = 'NAD', ylab = 'probability')
plotquantiles(x = nad2values,
    y = probsTS2$quantiles[, X$Sex == 'Female' & X$TreatmentGroup == 'Placebo',
        c(1, 4)],
    col = 3,
    add = TRUE)
flexiplot(x = nad1values,
    y = probsTS1$values[, X$Sex == 'Female' & X$TreatmentGroup == 'Placebo'],
    col = 7, lty = 1, lwd = 3,
    add = TRUE)
flexiplot(x = nad2values,
    y = probsTS2$values[, X$Sex == 'Female' & X$TreatmentGroup == 'Placebo'],
    col = 3, lty = 2, lwd = 3,
    add = TRUE)
legend('topright', bty = 'n',
    col = c(7, 3), lty = 1:2, lwd = 3,
    legend = c('Placebo, Female, Visit 1', 'Female, Placebo, Visit 2'))
dev.off()


## find max value to plot
ymax <- max(probsTSr$quantiles[, X$Sex == 'Female', ])
mypdf('NADratio_comparisons_female', portrait = FALSE)
par(mgp = c(1, 0, 0),
    oma = c(0.5, 0.5, 0.5, 0.5),
    mar = c(2, 2, 0, 0)) # space for one row of text at ticks and to separate plots
## Plot distributions for Female, NR
plotquantiles(x = nadratiovalues,
    y = probsTSr$quantiles[, X$Sex == 'Female' & X$TreatmentGroup == 'NR',
        c(1, 4)],
    col = 2, ylim = c(0, ymax),
    xlab = 'NAD ratio visit2/visit1', ylab = 'probability')
plotquantiles(x = nadratiovalues,
    y = probsTSr$quantiles[, X$Sex == 'Female' & X$TreatmentGroup == 'Placebo',
        c(1, 4)],
    col = 3,
    add = TRUE)
flexiplot(x = nadratiovalues,
    y = probsTSr$values[, X$Sex == 'Female' & X$TreatmentGroup == 'NR'],
    col = 2, lty = 1, lwd = 3,
    add = TRUE)
flexiplot(x = nadratiovalues,
    y = probsTSr$values[, X$Sex == 'Female' & X$TreatmentGroup == 'Placebo'],
    col = 3, lty = 2, lwd = 3,
    add = TRUE)
legend('topright', bty = 'n',
    col = c(2, 3), lty = 1:2, lwd = 3,
    legend = c('NR, Female', 'Placebo, Female'))
dev.off()

##############################################
#### probability that ratio > 1

tailprobsTSr <- tailPr(
    Y = data.frame(ratio21.NAD = 1),
    X = X,
    nsamples = 'all',
    lower.tail = FALSE,
    learnt = learntdir,
    parallel = parallel
)

cbind(X, data.frame(pr=c(tailprobsTSr$values),
    uncl = c(tailprobsTSr$quantiles[, , 1]),
    unch = c(tailprobsTSr$quantiles[, , 4])
    ))
##   TreatmentGroup    Sex       pr     uncl     unch
## 1             NR Female 0.624573 0.409809 0.813512
## 2        Placebo Female 0.542801 0.335800 0.737298
## 3             NR   Male 0.662428 0.497231 0.810265
## 4        Placebo   Male 0.582846 0.410046 0.744787


sampleslarger <- tailprobsTSr$samples[,
    X$Sex == 'Male' & X$TreatmentGroup == 'NR', ] -
    tailprobsTSr$samples[,
        X$Sex == 'Male' & X$TreatmentGroup == 'Placebo', ]

sum(sampleslarger > 0)/length(sampleslarger)
mean(sampleslarger)

myhist(tailprobsTSr$samples[,
    X$Sex == 'Male' & X$TreatmentGroup == 'NR', ], col = 3, plot=T, border=3)
myhist(tailprobsTSr$samples[,
    X$Sex == 'Male' & X$TreatmentGroup == 'Placebo', ], plot=T, add = T, col=2, border=2)
