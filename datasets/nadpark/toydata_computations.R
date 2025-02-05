library('inferno')

## Choose how many parallel cores to use for the calculation
parallel <- 4

## Name of directory where the "learning" has been saved
learnt <- 'output_learn_toydata-4'

Agevalues <- 40:80
TreatmentGroups <- c('NR', 'Placebo')
Sexvalues <- c('Male', 'Female')
Smellvalues <- c('Yes', 'No')
Sleepvalues <- c('Yes', 'No')

X <- expand.grid(
    Age = Agevalues,
    Sex = Sexvalues,
    TreatmentGroup = TreatmentGroups,
    Anamnestic.Loss.of.smell = Smellvalues,
    History.of.REM.Sleep.Behaviour.Disorder = Sleepvalues,
    stringsAsFactors = FALSE
)

probabilities <- tailPr(
    Y = data.frame(diff.MDS.UPRS.III = -1),
    X = X,
    learnt = learnt,
    parallel = parallel
)

plot <- probabilities$values

dim(plot) <- c(
    length(Agevalues), # rows
    length(plot)/length(Agevalues) # rest
)

flexiplot(
    x = Agevalues,
    y = plot,
    xlab = 'Age',
    ylab = 'probability',
    lty = 1, lwd = 2,
    col = adjustcolor(1:7, 0.5),
    ylim = c(0, NA)
)

legend('bottomright',
    legend = apply(X[X$Age == 40, -1], 1, paste, collapse=', '),
    lty = 1, lwd = 2,
    col = 1:7,
    bty = 'n'
    )

#save as image file: jpeg('Images/v2/Sex.jpg', height=5.8, width=8.3, res=300, units='in', quality=90)