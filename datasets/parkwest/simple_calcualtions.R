library(inferno)

parallel <- 3

learntdir <- 'output_irene_data_3-vrt14_dat92_smp3600'
learnt <- file.path('_data', learntdir)
probs_PFC <- readRDS('probs_PFC_scaled.rds')

emin_PFC <- min(probs_PFC$X$Ethanol_units, na.rm = TRUE)
emax_PFC <- max(probs_PFC$X$Ethanol_units, na.rm = TRUE)
cmin_PFC <- min(probs_PFC$X$Daily_cigarettes, na.rm = TRUE)
cmax_PFC <- max(probs_PFC$X$Daily_cigarettes, na.rm = TRUE)


vrts <- list(
    ## Group = c('Ctrl', 'PD'),
    PD_subtype_AR_TD = c("AR","Mixed","TD"),
    PD_subtype_PIGD_TD = c("PIGD","Mixed","TD"),
    PFC1_percent = 85:100,
    SNpc_percent = 15:100,
    Sex = c('F', 'M'),
    PMI = 1:131,
    DV200 = 65:100,
    RIN = 1:10,
    Daily_cigarettes = 0:35,
    Ethanol_units = 0:16,
    Age_of_death = 46:100
)
qtiles <- c(0.055, 0.945)

Y_PFC <- data.frame(PFC1_percent = vrts$PFC1_percent)
Y_SNpc <- data.frame(SNpc_percent = vrts$SNpc_percent)
X_0 <- data.frame(Sex = 'F', Daily_cigarettes = 0, Ethanol_units = 0)
X_4 <- data.frame(Sex = 'F', Daily_cigarettes = 0, Ethanol_units = 4)
probs_0 <- Pr(Y = Y_PFC, X = X_0, learnt = learnt, quantiles = qtiles, parallel = parallel)
probs_4 <- Pr(Y = Y_PFC, X = X_4, learnt = learnt, quantiles = qtiles, parallel = parallel)

#pdf(file = paste0('Images/PFC/PFC_SubgroupExample.pdf'),
#        paper = 'special', height=148/25.4*1.5, width=210/25.4*1.5)
jpeg('Images/PFC/PFC_SubgroupExample.jpg', height=5.8, width=8.3, res=300, units='in', quality=90)

plot(probs_0, col = 1, lty = 1, legend=FALSE)
plot(probs_4, col = 2, lty = 2, add = TRUE, legend=FALSE)
legend("topleft", legend = c(
            paste("Ethanol_units = ", X_0$Ethanol_units, ", Daily_cigarettes = ", X_0$Daily_cigarettes),
            paste("Ethanol_units = ", X_4$Ethanol_units, ", Daily_cigarettes = ", X_4$Daily_cigarettes)),
            col = c(1,2), lty = (1:2), lwd = 2, bty = 'n')
legend("topright", legend = c(
            "Gender: Female",
            "Value: PFC"))
dev.off()