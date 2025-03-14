library(shiny)
library(inferno)
library(htmlwidgets)
library(plotly)

## Probabilities have been pre-calculated in script
## 'analysis_irene_data_4.R'
## and saved in 'probs_noEthanol.rds'

probs0 <- readRDS('probs_F_reverse.rds')

## function to subset an object of class probability
## (this will be included in the software later on)
subsetpr <- function(probj, vrt, vrtval) {
    sel <- probj$X[[vrt]] == vrtval
    probj$values <- probj$values[, sel, drop = FALSE]
    probj$quantiles <- probj$quantiles[ , sel, , drop = FALSE]
    probj$samples <- probj$samples[ , sel, , drop = FALSE]
    probj$X[[vrt]] <- NULL
    probj$X <- probj$X[sel, , drop = FALSE]
    probj
}

ui <- fluidPage(
    titlePanel("Pr(PFC1_percent | Sex = Female, Ethanol_units, Cigarettes)"),
    ##
    ## Sidebar layout with sliders for y1 and y2
    sidebarLayout(
        sidebarPanel(
            sliderInput("y1",
                "Ethanol_units 1:",
                min = 0,
                max = 35,
                value = 0,
                step = 1),
            sliderInput("y2",
                "Ethanol_units 2:",
                min = 0,
                max = 35,
                value = 0,
                step = 1),
            sliderInput("y3",
                "Daily_cigarettes 1:",
                min = 0,
                max = 35,
                value = 0,
                step = 1),
            sliderInput("y4",
                "Daily_cigarettes 2:",
                min = 0,
                max = 35,
                value = 0,
                step = 1)
            ),
        mainPanel(plotOutput("distPlot"))
        )
        ##
        )


server <- function(input, output) {
    output$distPlot <- renderPlot({
        ##
        y1 <- input$y1
        y2 <- input$y2
        y3 <- input$y3
        y4 <- input$y4

        ## create probability-class objects with given number of Daily_cig
        prob1 <- subsetpr(subsetpr(probs0, 'Ethanol_units', y1), 'Daily_cigarettes', y3)
        prob2 <- subsetpr(subsetpr(probs0, 'Ethanol_units', y2), 'Daily_cigarettes', y4)
        ##
        ## colours must still be adjusted
        plot(prob1,
            ylim = c(0,1),
            col = 1:2)
        plot(prob2, col = 3:4, add = TRUE)
        ##
        legend("topleft", legend = c(
            paste("Ethanol_units 1 =", y1, ", Daily_cigarettes 1 =", y3),
            paste("Ethanol_units 2 =", y2, ", Daily_cigarettes 2 =", y4)),
            col = c(1, 3), lty = 1, lwd = 2, bty='n')
    }) 
}

app <- shinyApp(ui = ui, server = server)
runApp(app)
