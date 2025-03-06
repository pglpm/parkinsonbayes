library(plotly)
library('inferno')

parallel <- 2
learnt <- file.path('_data','output_irene_data_3-vrt14_dat92_smp3600')

PD_subtype_PIGD_TD = 'TD' #c("PIGD","Mixed","TD")
SNpc_percent = 15:100
Daily_cigarettes = 0:5

steps <- list()
fig <- plot_ly()
for(i in seq_along(Daily_cigarettes)) {  # Use seq_along to get valid indices
    cig_value <- Daily_cigarettes[i]  # Actual cigarette count
    
    X <- data.frame(SNpc_percent = SNpc_percent)
    Y <- data.frame(PD_subtype_PIGD_TD = PD_subtype_PIGD_TD, Daily_cigarettes = cig_value)
    fig <- add_lines(fig, x = SNpc_percent, 
                     y = Pr(Y = Y, X = X, learnt = learnt, quantiles = c(0.055, 0.945), parallel = parallel)$values, 
                     name = paste('Daily cigarettes =', cig_value))
    
    step <- list(args = list('visible', rep(FALSE, length(Daily_cigarettes))),
                 method = 'restyle')
    step$args[[2]][i] <- TRUE  # Now `i` is always at least 1
    steps[[i]] <- step
}

fig <- fig %>%
  layout(sliders = list(list(active = 0,
                             currentvalue = list(prefix = "Daily cigarettes: "),
                             steps = steps)))

print(fig)
