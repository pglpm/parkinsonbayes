library(plotly)
library(inferno)  # Make sure inferno is installed & loaded

parallel <- 3
learnt <- file.path('_data','output_irene_data_3-vrt14_dat92_smp3600')

PD_subtype_PIGD_TD = c("PIGD","Mixed","TD")
SNpc_percent = 15:100
Daily_cigarettes = 0:40

# Prepare data frame for X and Y inputs
X <- data.frame(SNpc_percent = SNpc_percent)
Y <- data.frame(PD_subtype_PIGD_TD = PD_subtype_PIGD_TD)

# Compute probabilities for each Daily_cigarettes value
prob_list <- lapply(Daily_cigarettes, function(cigs) {
  Z <- data.frame(Daily_cigarettes = cigs)  # Single value for each iteration
  Pr(Y = Y, X = X, learnt = learnt, quantiles = c(0.055, 0.945), parallel = parallel)
})

# Convert the list to a dataframe
probs_df <- data.frame(Daily_cigarettes = rep(Daily_cigarettes, each = length(SNpc_percent)),
                       SNpc_percent = rep(SNpc_percent, times = length(Daily_cigarettes)),
                       Pr = unlist(prob_list))

# Create the plot with animation
fig <- plot_ly(probs_df, x = ~SNpc_percent, y = ~Pr, frame = ~Daily_cigarettes, type = 'scatter', mode = 'lines+markers') %>%
  layout(
    title = "Probability vs SNpc Percent (Varying Daily Cigarettes)",
    xaxis = list(title = "SNpc Percent"),
    yaxis = list(title = "Probability"),
    updatemenus = list(
      list(
        type = "buttons",
        showactive = FALSE,
        buttons = list(
          list(label = "Play",
               method = "animate",
               args = list(NULL, list(frame = list(duration = 500, redraw = TRUE),
                                      fromcurrent = TRUE))),
          list(label = "Pause",
               method = "animate",
               args = list(NULL, list(mode = "immediate",
                                      frame = list(duration = 0, redraw = FALSE),
                                      transition = list(duration = 0))))
        )
      )
    ),
    sliders = list(
      list(
        currentvalue = list(prefix = "Daily Cigarettes: "),
        steps = lapply(unique(probs_df$Daily_cigarettes), function(cigs) {
          list(
            method = "animate",
            args = list(list(as.character(cigs)), list(mode = "immediate", frame = list(duration = 500, redraw = TRUE))),
            label = as.character(cigs)
          )
        })
      )
    )
  )

print(fig)
