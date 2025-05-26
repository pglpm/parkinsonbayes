library('inferno')

parallel <- 3
learnt <- '_data/output_learn_NADPARK-significancy'
Agevalues <- 40:80

# Define model input values
Y_list <- list(
  '1star' = data.frame(NAD.ATP.1star.ratio21 = 1),
  '2star' = data.frame(GDF15.serum.2star.ratio = 1),
  '3star' = data.frame(Muscle.Me.NAAD.3star.ratio = 1),
  '4star' = data.frame(PBMCs.Me.Nam.4star.ratio21 = 1)
)

# Custom display names
display_names <- list(
  '1star' = 'NAD.ATP (1-star)',
  '2star' = 'GDF15 (2-star)',
  '3star' = 'Muscle.Me.NAAD (3-star)',
  '4star' = 'PBMCs.Me.Nam (4-star)'
)

# Tail direction for each plot
lower_tail_flags <- c('1star' = FALSE, '2star' = TRUE, '3star' = FALSE, '4star' = FALSE)

XNR <- expand.grid(Age = Agevalues, TreatmentGroup = 'NR', stringsAsFactors = FALSE)
XPl <- expand.grid(Age = Agevalues, TreatmentGroup = 'Placebo', stringsAsFactors = FALSE)

colors <- c('NR' = 1, 'Placebo' = 2)

for (name in names(Y_list)) {
  Y <- Y_list[[name]]
  lower.tail <- lower_tail_flags[[name]]
  label <- display_names[[name]]
  
  # Compute probabilities
  probsNR <- tailPr(Y = Y, X = XNR, learnt = learnt, parallel = parallel,
                    quantiles = c(0.055, 0.945), lower.tail = lower.tail)
  probsPl <- tailPr(Y = Y, X = XPl, learnt = learnt, parallel = parallel,
                    quantiles = c(0.055, 0.945), lower.tail = lower.tail)
  
  # Save plot
  jpeg(file = file.path('Images', paste0('significancy_', name, '.png')), 
       height = 5.8, width = 8.3, res = 300, units = 'in', quality = 90)
  
  plot(probsNR, col = colors['NR'], legend = FALSE,
       xlab = 'Age', ylab = 'Probability of positive change', ylim = c(0, 1))
  
  plot(probsPl, col = colors['Placebo'], legend = FALSE, add = TRUE)
  
  legend('topright',
         legend = c(paste(label, 'NR'), paste(label, 'Placebo')),
         col = c(colors['NR'], colors['Placebo']),
         lty = 1, lwd = 2, bty = 'n')
  
  dev.off()
}
