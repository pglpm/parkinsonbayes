library('inferno')

parallel <- 3

learnt <- '_data/output_learn_NADPARK-significancy'


probabilities <- Pr(
    Y = data.frame(Tot.MDS.UPDRS.diff21 = (-30):30),
    X = data.frame(Sex = 'Female', TreatmentGroup = 'NR'),
    learnt = learnt
)

#jpeg('Images/test.jpg', height=5.8, width=8.3, res=300, units='in', quality=90)

plot(probabilities, legend=("topright"), ylim=c(0, 0.15))
#dev.off()