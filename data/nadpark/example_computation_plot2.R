#### Example of calculation & plot of tail probabilities for different values
#### of the conditional variate

library('inferno')

## Choose how many parallel cores to use for the calculation
parallel <- 4

## Name of directory where the "learning" has been saved
learntdir <- 'output_learn_toydata-4'


## Consider three conditional variates: age, sex, treatment

Agevalues <- 31:60 # as an example
Sexvalues <- c('Female', 'Male')
TreatmentGroupvalues <- c('NR', 'Placebo')

## Generate all possible combinations into one data frame:
## X has 30*2*2 = 120 rows

X <- expand.grid(
    Age = Agevalues,
    Sex = Sexvalues,
    TreatmentGroup = TreatmentGroupvalues,
    ## option below is to avoid conversion to factors
    stringsAsFactors = FALSE
)

## Check the result: "Age" is the one that changes first
head(X)

## We calculate the probability that diff.MDS.UPRS.III is <= -1,
## for all possible combinations of values in X

probs <- tailPr(
    Y = data.frame(diff.MDS.UPRS.III = -1),
    X = X,
    learnt = learntdir,
    parallel = parallel
)

## We are interested in probs$values, which is a 1-by-120 matrix.
## Its values are:
## Pr(diff <= -1  |  Age=31, Sex=Female, Treat=NR)
## Pr(diff <= -1  |  Age=32, Sex=Female, Treat=NR)
## ...
## Pr(diff <= -1  |  Age=60, Sex=Male, Treat=Placebo)
plottedprobs <- probs$values

## We want to plot Age as x-axis,
## so its values need to be rows of a matrix for flexiplot to work
dim(plottedprobs) <- c(
    length(Agevalues), # rows
    length(plottedprobs)/length(Agevalues) # rest
)

## Plot.
## It doesn't really matter if colours are repeated,
## we just want to see if any curves stand out.
flexiplot(
    x = Agevalues,
    y = plottedprobs,
    xlab = 'Age',
    ylab = 'probability',
    lty = 1, lwd = 2,
    col = adjustcolor(1:7, 0.5), # give some transparency
    ylim = c(0, NA) # we want to see the zero
)
legend('right',
    legend = apply(X[X$Age == 31, -1], 1, paste, collapse=', '),
    lty = 1, lwd = 2,
    col = 1:7,
    bty = 'n'
)
