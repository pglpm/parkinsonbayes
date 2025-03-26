library(shiny)
library(inferno)

## probs0 <- readRDS('probs_F_reverse.rds')
## Find min/max of each slider variate
## emin <- min(probs0$Y$Ethanol_units, na.rm = TRUE)
## emax <- max(probs0$Y$Ethanol_units, na.rm = TRUE)
## cmin <- min(probs0$Y$Daily_cigarettes, na.rm = TRUE)
## cmax <- max(probs0$Y$Daily_cigarettes, na.rm = TRUE)

probs_PFC <- readRDS('probs_F_PFC.rds')
probs_SNpc <- readRDS('probs_F_SNpc.rds')
## Find min/max of each slider variate
emin <- min(probs_PFC$X$Ethanol_units, na.rm = TRUE)
emax <- max(probs_PFC$X$Ethanol_units, na.rm = TRUE)
cmin <- min(probs_PFC$X$Daily_cigarettes, na.rm = TRUE)
cmax <- max(probs_PFC$X$Daily_cigarettes, na.rm = TRUE)

ui <- fluidPage(
    titlePanel(paste0('Pr(',
        paste0(names(probs_PFC$Y), collapse=', '),
        ' | ',
        paste0(names(probs_PFC$X), collapse=', '),
        ')')),
    ##
    ## Sidebar layout with sliders for e1 and e2
    sidebarLayout(
        sidebarPanel(
            sliderInput("e1",
                "Ethanol_units 1:",
                min = emin,
                max = emax,
                value = emin,
                step = 1),
            sliderInput("c1",
                "Daily_cigarettes 1:",
                min = cmin,
                max = cmax,
                value = cmin,
                step = 1),
            sliderInput("e2",
                "Ethanol_units 2:",
                min = emin,
                max = emax,
                value = emin,
                step = 1),
            sliderInput("c2",
                "Daily_cigarettes 2:",
                min = cmin,
                max = cmax,
                value = cmin,
                step = 1),
            actionButton("SNpc", "SNpc"),
            actionButton("PFC", "PFC")
            ),
        mainPanel(plotOutput("distPlot"))
        )
        ##
        )


server <- function(input, output, session) {
    output$distPlot <- renderPlot({

        ## slider values
        e1 <- input$e1
        e2 <- input$e2
        c1 <- input$c1
        c2 <- input$c2

        observeEvent(input$SNpc, {
            probs1_SNpc <- subset(probs_SNpc, list(Ethanol_units = e1, Daily_cigarettes = c1))
            probs2_SNpc <- subset(probs_SNpc, list(Ethanol_units = e2, Daily_cigarettes = c2))

            ## Find max of probabilities, including quantiles
            ymax <- max(probs1_SNpc$quantiles, probs2_PFC$quantiles, na.rm=TRUE)

            ## colours must still be adjusted
            plot(probs1_SNpc,
                ylim = c(0, ymax),
                col = 1:2, legend = FALSE)
            plot(probs2_SNpc, col = 3:4, add = TRUE, legend = FALSE)
            ##
            legend("topleft", legend = c(
                paste("Ethanol_units 1 =", e1, ", Daily_cigarettes 1 =", c1),
                paste("Ethanol_units 2 =", e2, ", Daily_cigarettes 2 =", c2)),
                col = c(1, 3), lty = 1, lwd = 2, bty='n')
        })

        observeEvent(input$PFC, {
            ## create probability-class objects with given number of Daily_cig
            probs1_PFC <- subset(probs_PFC, list(Ethanol_units = e1, Daily_cigarettes = c1))
            probs2_PFC <- subset(probs_PFC, list(Ethanol_units = e2, Daily_cigarettes = c2))

            ## Find max of probabilities, including quantiles
            ymax <- max(probs1_PFC$quantiles, probs2_PFC$quantiles, na.rm=TRUE)

            ## colours must still be adjusted
            plot(probs1_PFC,
                ylim = c(0, ymax),
                col = 1:2, legend = FALSE)
            plot(probs2_PFC, col = 3:4, add = TRUE, legend = FALSE)
            ##
            legend("topleft", legend = c(
                paste("Ethanol_units 1 =", e1, ", Daily_cigarettes 1 =", c1),
                paste("Ethanol_units 2 =", e2, ", Daily_cigarettes 2 =", c2)),
                col = c(1, 3), lty = 1, lwd = 2, bty='n')
        })
    }) 
}

app <- shinyApp(ui = ui, server = server)
runApp(app)
