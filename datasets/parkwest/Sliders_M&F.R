library(shiny)
library(inferno)

# Female data
probs_PFC_F <- readRDS('probs_F_PFC.rds')
probs_SNpc_F <- readRDS('probs_F_SNpc.rds')

# Male data
probs_PFC_M <- readRDS('probs_M_PFC.rds')
probs_SNpc_M <- readRDS('probs_M_SNpc.rds')

# UI
ui <- fluidPage(
    uiOutput("page_title"),  # Dynamically updated title
    
    sidebarLayout(
        sidebarPanel(
            actionButton("female_btn", "Female"),
            actionButton("male_btn", "Male"),
            br(), br(),
            sliderInput("e1", "Ethanol_units 1:", min = 0, max = 1, value = 0, step = 1),
            sliderInput("c1", "Daily_cigarettes 1:", min = 0, max = 1, value = 0, step = 1),
            sliderInput("e2", "Ethanol_units 2:", min = 0, max = 1, value = 0, step = 1),
            sliderInput("c2", "Daily_cigarettes 2:", min = 0, max = 1, value = 0, step = 1)
        ),
        
        mainPanel(
            tabsetPanel(
                id = "selected_tab",
                tabPanel("SNpc", plotOutput("SNpcPlot")),
                tabPanel("PFC", plotOutput("PFCPlot"))
            )
        )
    )
)

# Server
server <- function(input, output, session) {
    
    gender <- reactiveVal("Female")  # Default gender

    output$page_title <- renderUI({
        #titlePanel(paste("Probability Plots -", gender()))  # Updates page title dynamically
        titlePanel(paste("P(", input$selected_tab, " | ", gender(), ", Daily_cigarettes, Ethanol_units)"))
    })

    observeEvent(input$female_btn, {
        gender("Female")
        update_sliders()
    })
    
    observeEvent(input$male_btn, {
        gender("Male")
        update_sliders()
    })

    dataset <- reactive({
        if (gender() == "Female") {
            list(PFC = probs_PFC_F, SNpc = probs_SNpc_F)
        } else {
            list(PFC = probs_PFC_M, SNpc = probs_SNpc_M)
        }
    })

    # Function to update slider ranges
    update_sliders <- function() {
        if (input$selected_tab == "SNpc") {
            updateSliderInput(session, "e1", min = min(dataset()$SNpc$X$Ethanol_units, na.rm = TRUE), 
                              max = max(dataset()$SNpc$X$Ethanol_units, na.rm = TRUE), 
                              value = min(dataset()$SNpc$X$Ethanol_units, na.rm = TRUE))
            updateSliderInput(session, "c1", min = min(dataset()$SNpc$X$Daily_cigarettes, na.rm = TRUE), 
                              max = max(dataset()$SNpc$X$Daily_cigarettes, na.rm = TRUE), 
                              value = min(dataset()$SNpc$X$Daily_cigarettes, na.rm = TRUE))
            updateSliderInput(session, "e2", min = min(dataset()$SNpc$X$Ethanol_units, na.rm = TRUE), 
                              max = max(dataset()$SNpc$X$Ethanol_units, na.rm = TRUE), 
                              value = min(dataset()$SNpc$X$Ethanol_units, na.rm = TRUE))
            updateSliderInput(session, "c2", min = min(dataset()$SNpc$X$Daily_cigarettes, na.rm = TRUE), 
                              max = max(dataset()$SNpc$X$Daily_cigarettes, na.rm = TRUE), 
                              value = min(dataset()$SNpc$X$Daily_cigarettes, na.rm = TRUE))
        } else {
            updateSliderInput(session, "e1", min = min(dataset()$PFC$X$Ethanol_units, na.rm = TRUE), 
                              max = max(dataset()$PFC$X$Ethanol_units, na.rm = TRUE), 
                              value = min(dataset()$PFC$X$Ethanol_units, na.rm = TRUE))
            updateSliderInput(session, "c1", min = min(dataset()$PFC$X$Daily_cigarettes, na.rm = TRUE), 
                              max = max(dataset()$PFC$X$Daily_cigarettes, na.rm = TRUE), 
                              value = min(dataset()$PFC$X$Daily_cigarettes, na.rm = TRUE))
            updateSliderInput(session, "e2", min = min(dataset()$PFC$X$Ethanol_units, na.rm = TRUE), 
                              max = max(dataset()$PFC$X$Ethanol_units, na.rm = TRUE), 
                              value = min(dataset()$PFC$X$Ethanol_units, na.rm = TRUE))
            updateSliderInput(session, "c2", min = min(dataset()$PFC$X$Daily_cigarettes, na.rm = TRUE), 
                              max = max(dataset()$PFC$X$Daily_cigarettes, na.rm = TRUE), 
                              value = min(dataset()$PFC$X$Daily_cigarettes, na.rm = TRUE))
        }
    }

    observeEvent(input$selected_tab, {
        update_sliders()
    })

    output$SNpcPlot <- renderPlot({
        req(input$selected_tab == "SNpc")

        probs1 <- subset(dataset()$SNpc, list(Ethanol_units = input$e1, Daily_cigarettes = input$c1))
        probs2 <- subset(dataset()$SNpc, list(Ethanol_units = input$e2, Daily_cigarettes = input$c2))

        ymax <- max(probs1$quantiles, probs2$quantiles, na.rm = TRUE)

        plot(probs1, ylim = c(0, ymax), col = 1:2, legend = FALSE)
        plot(probs2, col = 3:4, add = TRUE, legend = FALSE)

        legend("topleft", legend = c(
            paste("Ethanol_units 1 =", input$e1, ", Daily_cigarettes 1 =", input$c1),
            paste("Ethanol_units 2 =", input$e2, ", Daily_cigarettes 2 =", input$c2)),
            col = c(1, 3), lty = 1, lwd = 2, bty = 'n')
        legend("topright", legend = c(
                    paste("Gender: ", gender()),
                    paste("Value: ", input$selected_tab))
        )
    })

    output$PFCPlot <- renderPlot({
        req(input$selected_tab == "PFC")

        probs1 <- subset(dataset()$PFC, list(Ethanol_units = input$e1, Daily_cigarettes = input$c1))
        probs2 <- subset(dataset()$PFC, list(Ethanol_units = input$e2, Daily_cigarettes = input$c2))

        ymax <- max(probs1$quantiles, probs2$quantiles, na.rm = TRUE)

        plot(probs1, ylim = c(0, ymax), col = 1:2, legend = FALSE)
        plot(probs2, col = 3:4, add = TRUE, legend = FALSE)

        legend("topleft", legend = c(
            paste("Ethanol_units 1 =", input$e1, ", Daily_cigarettes 1 =", input$c1),
            paste("Ethanol_units 2 =", input$e2, ", Daily_cigarettes 2 =", input$c2)),
            col = c(1, 3), lty = 1, lwd = 2, bty = 'n')
        legend("topright", legend = c(
                    paste("Gender: ", gender()),
                    paste("Value: ", input$selected_tab))
        )
    })
}

app <- shinyApp(ui = ui, server = server)
runApp(app)