library(shiny)
library(inferno)
library(htmlwidgets)
library(plotly)

probs_ethanol <- readRDS('probs_Ethanol_F.rds')
probs_Cigarettes <- readRDS('probs_Cigarettes_F.rds')

PD_subtype_AR_TD = c("AR","Mixed","TD")

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
    sidebarLayout(
        sidebarPanel(
            sliderInput("y1", "Ethanol_units 1:", min = 0, max = 16, value = 0, step = 1),
            #sliderInput("y2", "Ethanol_units 2:", min = 0, max = 16, value = 0, step = 1),
            sliderInput("y3", "Daily cigarettes 1:", min = 0, max = 35, value = 0, step = 1),
            #sliderInput("y4", "Daily cigarettes 2:", min = 0, max = 35, value = 0, step = 1),
            #actionButton("AR_subtype", "AR"),
            #actionButton("Mixed_subtype", "Mixed"),
            #actionButton("TD_subtype", "TD")
        ),
        mainPanel(plotOutput("distPlot"))
    ),
)


server <- function(input, output) {

    observeEvent(input$AR_subtype, {
        PD_subtype_AR_TD <- "AR"
    })
    observeEvent(input$Mixed_subtype, {
        PD_subtype_AR_TD <- "Mixed"
    })
    observeEvent(input$TD_subtype, {
        PD_subtype_AR_TD <- "TD"
    })

    output$distPlot <- renderPlot({
        y1 <- input$y1
        #y2 <- input$y2
        y3 <- input$y3
        #y4 <- input$y4

        # Filter data based on selected gender
        prob_Ethanol_1 <- subsetpr(probs_ethanol, 'Ethanol_units', y1)
        #prob_Ethanol_2 <- subsetpr(probs_ethanol, 'Ethanol_units', y2)

        prob_Cigarettes_1 <- subsetpr(probs_Cigarettes, 'Daily_cigarettes', y3)
        #prob_Cigarettes_2 <- subsetpr(probs_Cigarettes, 'Daily_cigarettes', y4)

        plot(prob_Ethanol_1,
            ylim = c(0, max(prob_Ethanol_1$quantiles, prob_Ethanol_1$quantiles)),
            col = 1:2)
        #plot(prob_Ethanol_2, col = 3:4, add = TRUE)
        plot(prob_Cigarettes_1, col = 3:4, add = TRUE)
        #plot(prob_Cigarettes_2, col = 7:8, add = TRUE)

        legend("topleft", legend = c(
            paste("Ethanol_units =", y1),
            #paste("Ethanol_units =", y2)),
            paste("Daily_cigarettes =", y3)),
            #paste("Daily_cigarettes =", y4)),
            col = c(1:4), lty = 1, lwd = 2, bty='n')
    })
}

app <- shinyApp(ui = ui, server = server)

runApp(app)
