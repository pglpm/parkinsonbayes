library('inferno')

## Choose how many parallel cores to use for the calculation
parallel <- 2

## Name of directory where the "learning" has been saved
learnt <- 'output_learnt_toydata'

probabilities <- Pr(
    Y = data.frame(diff.MDS.UPDRS.III = (-30):30),
    X = data.frame(Sex = 'Female', TreatmentGroup = 'NR'),
    learnt = learnt
)

jpeg('Images/UPDRS_graph.jpg', height=5.8, width=8.3, res=300, units='in', quality=90)

plot(probabilities, legend=("topright"), ylab = 'Pr of diff.MDS.UPDRS.III',ylim=c(0, 0.15))
dev.off()
