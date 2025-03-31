library(shiny)
library(inferno)

# Female data
probs_PFC <- readRDS('probs_F_PFC.rds')
probs_SNpc <- readRDS('probs_F_SNpc.rds')


# min/max values for PFC
emin_PFC <- min(probs_PFC$X$Ethanol_units, na.rm = TRUE)
emax_PFC <- max(probs_PFC$X$Ethanol_units, na.rm = TRUE)
cmin_PFC <- min(probs_PFC$X$Daily_cigarettes, na.rm = TRUE)
cmax_PFC <- max(probs_PFC$X$Daily_cigarettes, na.rm = TRUE)

# min/max values for SNpc
emin_SNpc <- min(probs_SNpc$X$Ethanol_units, na.rm = TRUE)
emax_SNpc <- max(probs_SNpc$X$Ethanol_units, na.rm = TRUE)
cmin_SNpc <- min(probs_SNpc$X$Daily_cigarettes, na.rm = TRUE)
cmax_SNpc <- max(probs_SNpc$X$Daily_cigarettes, na.rm = TRUE)

ui <- fluidPage(
    titlePanel("Probability Plots"),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("e1", "Ethanol_units 1:", min = 0, max = 1, value = 0, step = 1),
            sliderInput("c1", "Daily_cigarettes 1:", min = 0, max = 1, value = 0, step = 1),
            sliderInput("e2", "Ethanol_units 2:", min = 0, max = 1, value = 0, step = 1),
            sliderInput("c2", "Daily_cigarettes 2:", min = 0, max = 1, value = 0, step = 1)
        ),
        
        mainPanel(
            tabsetPanel(
                id = "selected_tab",
                tabPanel("SNpc Plot", plotOutput("SNpcPlot")),
                tabPanel("PFC Plot", plotOutput("PFCPlot"))
            )
        )
    )
)

server <- function(input, output, session) {
    
    # Detect tab switch and update slider ranges
    observeEvent(input$selected_tab, {
        if (input$selected_tab == "SNpc Plot") {
            updateSliderInput(session, "e1", min = emin_SNpc, max = emax_SNpc, value = emin_SNpc)
            updateSliderInput(session, "c1", min = cmin_SNpc, max = cmax_SNpc, value = cmin_SNpc)
            updateSliderInput(session, "e2", min = emin_SNpc, max = emax_SNpc, value = emin_SNpc)
            updateSliderInput(session, "c2", min = cmin_SNpc, max = cmax_SNpc, value = cmin_SNpc)
        } else {
            updateSliderInput(session, "e1", min = emin_PFC, max = emax_PFC, value = emin_PFC)
            updateSliderInput(session, "c1", min = cmin_PFC, max = cmax_PFC, value = cmin_PFC)
            updateSliderInput(session, "e2", min = emin_PFC, max = emax_PFC, value = emin_PFC)
            updateSliderInput(session, "c2", min = cmin_PFC, max = cmax_PFC, value = cmin_PFC)
        }
    })
    
    # SNpc Plot
    output$SNpcPlot <- renderPlot({
        req(input$selected_tab == "SNpc Plot")

        e1 <- input$e1
        e2 <- input$e2
        c1 <- input$c1
        c2 <- input$c2

        probs1 <- subset(probs_SNpc, list(Ethanol_units = e1, Daily_cigarettes = c1))
        probs2 <- subset(probs_SNpc, list(Ethanol_units = e2, Daily_cigarettes = c2))

        ymax_SNpc <- max(probs1$quantiles, probs2$quantiles, na.rm = TRUE)

        plot(probs1, ylim = c(0, ymax_SNpc), col = 1:2, legend = FALSE)
        plot(probs2, col = 3:4, add = TRUE, legend = FALSE)

        legend("topleft", legend = c(
            paste("Ethanol_units 1 =", e1, ", Daily_cigarettes 1 =", c1),
            paste("Ethanol_units 2 =", e2, ", Daily_cigarettes 2 =", c2)),
            col = c(1, 3), lty = 1, lwd = 2, bty = 'n')
    })
    
    # PFC Plot
    output$PFCPlot <- renderPlot({
        req(input$selected_tab == "PFC Plot")  # Only render when active

        e1 <- input$e1
        e2 <- input$e2
        c1 <- input$c1
        c2 <- input$c2

        probs1 <- subset(probs_PFC, list(Ethanol_units = e1, Daily_cigarettes = c1))
        probs2 <- subset(probs_PFC, list(Ethanol_units = e2, Daily_cigarettes = c2))

        ymax_PFC <- max(probs1$quantiles, probs2$quantiles, na.rm = TRUE)

        plot(probs1, ylim = c(0, ymax_PFC), col = 1:2, legend = FALSE)
        plot(probs2, col = 3:4, add = TRUE, legend = FALSE)

        legend("topleft", legend = c(
            paste("Ethanol_units 1 =", e1, ", Daily_cigarettes 1 =", c1),
            paste("Ethanol_units 2 =", e2, ", Daily_cigarettes 2 =", c2)),
            col = c(1, 3), lty = 1, lwd = 2, bty = 'n')
    })
}

app <- shinyApp(ui = ui, server = server)
runApp(app)