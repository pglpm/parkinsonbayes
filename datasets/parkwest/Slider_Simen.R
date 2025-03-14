library(shiny)
library(inferno)
## ## not needed
## library(htmlwidgets)
## library(plotly)

## Probabilities have been pre-calculated in script
## 'analysis_irene_data_4.R'
## and saved in 'probs_noEthanol.rds'

## probs0 <- readRDS('probs_F_reverse.rds')
## ## Find min/max of each slider variate
## emin <- min(probs0$Y$Ethanol_units, na.rm = TRUE)
## emax <- max(probs0$Y$Ethanol_units, na.rm = TRUE)
## cmin <- min(probs0$Y$Daily_cigarettes, na.rm = TRUE)
## cmax <- max(probs0$Y$Daily_cigarettes, na.rm = TRUE)

probs0 <- readRDS('probs_F.rds')
## Find min/max of each slider variate
emin <- min(probs0$X$Ethanol_units, na.rm = TRUE)
emax <- max(probs0$X$Ethanol_units, na.rm = TRUE)
cmin <- min(probs0$X$Daily_cigarettes, na.rm = TRUE)
cmax <- max(probs0$X$Daily_cigarettes, na.rm = TRUE)

ui <- fluidPage(
    titlePanel(paste0('Pr(',
        paste0(names(probs0$Y), collapse=', '),
        ' | ',
        paste0(names(probs0$X), collapse=', '),
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
            sliderInput("e2",
                "Ethanol_units 2:",
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
            sliderInput("c2",
                "Daily_cigarettes 2:",
                min = cmin,
                max = cmax,
                value = cmin,
                step = 1)
            ),
        mainPanel(plotOutput("distPlot"))
        )
        ##
        )


server <- function(input, output) {
    output$distPlot <- renderPlot({
        ##
        e1 <- input$e1
        e2 <- input$e2
        c1 <- input$c1
        c2 <- input$c2

        ## create probability-class objects with given number of Daily_cig
        prob1 <- subset(probs0, list(Ethanol_units = e1, Daily_cigarettes = c1))
        prob2 <- subset(probs0, list(Ethanol_units = e2, Daily_cigarettes = c2))

        ## Find max of probabilities, including quantiles
        ymax <- max(prob1$quantiles, prob2$quantiles, na.rm=TRUE)

        ## colours must still be adjusted
        plot(prob1,
            ylim = c(0, ymax),
            col = 1:2, legend = FALSE)
        plot(prob2, col = 3:4, add = TRUE, legend = FALSE)
        ##
        legend("topleft", legend = c(
            paste("Ethanol_units 1 =", e1, ", Daily_cigarettes 1 =", c1),
            paste("Ethanol_units 2 =", e2, ", Daily_cigarettes 2 =", c2)),
            col = c(1, 3), lty = 1, lwd = 2, bty='n')
    }) 
}

app <- shinyApp(ui = ui, server = server)
runApp(app)
