## Here are examples of possible questions and computations that one can do
## after the "learning" phase is complete.

library('inferno')

## Choose how many parallel cores to use for the calculation
parallel <- 4

## Name of directory where the "learning" has been saved
learntdir <- 'output_learn_toydata-4'

########################################
#### Example 1
########################################
## If we examine a new patient,
## and this patient is Male and belongs to the 'NR' treatment group,
## what kind of increase/decrease in 'diff.MDS.UPRS.III' will this patient have?
##
## This question effectively means that we consider all possible values/outcomes
## that 'diff.MDS.UPRS.III' could have, and calculate the probabiliy of each.
## (Check metadata file for variate names and admissible values.)
##
## predictor:
## Sex = 'Male' & TreatmentGroup = 'NR'
##
## predictand:
## diff.MDS.UPRS.III = all possible admissible values, from -132 to +132

## Create dataframe containing predictor values.
## One column per variate, one row per value of interest
X <- data.frame(Sex = 'Male', TreatmentGroup = 'NR')

## Create dataframe containing predictand values.
## One column per variate, one row per value of interest
Y <- data.frame(diff.MDS.UPRS.III = (-132):132)

## Now we calculate
## P(diff.MDS.UPRS.III = i | Sex = 'Male', TreatmentGroup = 'NR', data)
## for all admissible values of i
probabilities <- Pr(Y = Y, X = X, learnt = learntdir, parallel = parallel)

## The result is a list of three arrays:
## 1. The probability values.
## The Y values are the rows, and the X values the columns (in this case just 1)
## Example:
probabilities$values[1:3, 1, drop=FALSE]
##       X
## Y             [,1]
##   [1,] 1.48864e-04
##   [2,] 1.50579e-04
##   [3,] 1.75271e-06

## 2. The quantiles of variability of the probabilities.
## if more data were collected. The defaults are 5% and 95% quantiles,
## so there's a 90% probability that updated probabilities will lie
## between these two quantiles.
##
## The Y values are the rows, the X values the columns (in this case just 1)
## and the third dimension are the quantiles (in this case two).
## Example:
probabilities$quantiles[1:3, 1, , drop=FALSE]
## , ,  = 5%
## 
##       X
## Y             [,1]
##   [1,] 1.08412e-25
##   [2,] 1.96910e-25
##   [3,] 3.77502e-26
## 
## , ,  = 95%
## 
##       X
## Y             [,1]
##   [1,] 0.000315934
##   [2,] 0.000321468
##   [3,] 0.000005300

## 3. Samples of how the updated probabilities could be,
## if more data were collected.
## These are really Monte Carlo samples from the learning phase.
## 100 samples are stored as the third dimension of this array.
## The numbers of the corresponding Monte Carlo results are shown:
## Example:
probabilities$samples[1:3, 1, 1:2, drop=FALSE]
## , ,  = 1
## 
##       X
## Y             [,1]
##   [1,] 5.04301e-15
##   [2,] 5.39518e-15
##   [3,] 3.74338e-16
## 
## , ,  = 37
## 
##       X
## Y             [,1]
##   [1,] 8.90702e-08
##   [2,] 9.10918e-08
##   [3,] 2.05679e-09

## Let's plot the quantile band and the probabilities:
plotquantiles(x = as.matrix(Y$diff.MDS.UPRS.III),
    y = probabilities$quantiles[,1,],
    xlab = 'diff.MDS.UPRS.III',
    ylab = 'probability',
    col = 1,
    xlim = c(-40, 40), ylim =  c(0, NA))
##
tplot(x = as.matrix(Y$diff.MDS.UPRS.III),
    y = probabilities$values[,1],
    col = 1, add = TRUE)


########################################
#### Example 2
########################################
## Same as Example 1, but now we want to consider
## two different joint values of the joint predictor variates:
##
## Sex = 'Male' & TreatmentGroup = 'NR'
## Sex = 'Female' & TreatmentGroup = 'NR'
##
## We can still use the Pr() function. Now we'll obtain arrays
## with two columns, one for each joint value of X

## Create dataframe containing predictor values.
## One column per variate, one row per value of interest.
## Note that 'data.frame' automatically repeat values if needed,
## in this case 'NR'
X <- data.frame(Sex = c('Male', 'Female'), TreatmentGroup = 'NR')
##      Sex TreatmentGroup
## 1   Male             NR
## 2 Female             NR

## Create dataframe containing predictand values.
## One column per variate, one row per value of interest
Y <- data.frame(diff.MDS.UPRS.III = (-132):132)

## Now we calculate
## P(diff.MDS.UPRS.III = i | Sex = j, TreatmentGroup = 'NR', data)
## for all admissible values of i
## and for j = 'Male' and 'Female'
probabilities <- Pr(Y = Y, X = X, learnt = learntdir, parallel = parallel)

## Example of resulting array:
probabilities$values[1:3, , drop=FALSE]
##       X
## Y             [,1]        [,2]
##   [1,] 1.48864e-04 2.92848e-04
##   [2,] 1.50579e-04 2.95792e-04
##   [3,] 1.75271e-06 3.00103e-06


## Let's plot the quantile bands and the probabilities,
## for 'Male' in blue and 'Female' in red:
##
## Male
plotquantiles(x = as.matrix(Y$diff.MDS.UPRS.III),
    y = probabilities$quantiles[,1,],
    xlab = 'diff.MDS.UPRS.III',
    ylab = 'probability',
    col = 1,
    xlim = c(-40, 40), ylim =  c(0, NA))
##
## Female; we add to previous plot
plotquantiles(x = as.matrix(Y$diff.MDS.UPRS.III),
    y = probabilities$quantiles[,2,],
    xlab = 'diff.MDS.UPRS.III',
    ylab = 'probability',
    col = 2,
    xlim = c(-40, 40), ylim =  c(0, NA),
    add = TRUE)
##
## And now the probabilities; we add to previous plots
tplot(x = as.matrix(Y$diff.MDS.UPRS.III),
    y = probabilities$values[,],
    col = c(1,2), add = TRUE)

