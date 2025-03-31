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
    tags$head(tags$title("Probability Plots - Female")),  # Initial title
    titlePanel(textOutput("page_title")),  # Dynamic title
    
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
                tabPanel("SNpc Plot", plotOutput("SNpcPlot")),
                tabPanel("PFC Plot", plotOutput("PFCPlot"))
            )
        )
    )
)

# Server
server <- function(input, output, session) {
    
    gender <- reactiveVal("Female")  # Default gender

    output$page_title <- renderText({
        paste("Probability Plots -", gender())
    })

    observeEvent(input$female_btn, {
        gender("Female")
        session$sendCustomMessage("updateTitle", "Probability Plots - Female")
    })
    
    observeEvent(input$male_btn, {
        gender("Male")
        session$sendCustomMessage("updateTitle", "Probability Plots - Male")
    })

    dataset <- reactive({
        if (gender() == "Female") {
            list(PFC = probs_PFC_F, SNpc = probs_SNpc_F)
        } else {
            list(PFC = probs_PFC_M, SNpc = probs_SNpc_M)
        }
    })

    output$SNpcPlot <- renderPlot({
        req(input$selected_tab == "SNpc Plot")

        probs1 <- subset(dataset()$SNpc, list(Ethanol_units = input$e1, Daily_cigarettes = input$c1))
        probs2 <- subset(dataset()$SNpc, list(Ethanol_units = input$e2, Daily_cigarettes = input$c2))

        ymax <- max(probs1$quantiles, probs2$quantiles, na.rm = TRUE)

        plot(probs1, ylim = c(0, ymax), col = 1:2, legend = FALSE)
        plot(probs2, col = 3:4, add = TRUE, legend = FALSE)

        legend("topleft", legend = c(
            paste("Ethanol_units 1 =", input$e1, ", Daily_cigarettes 1 =", input$c1),
            paste("Ethanol_units 2 =", input$e2, ", Daily_cigarettes 2 =", input$c2)),
            col = c(1, 3), lty = 1, lwd = 2, bty = 'n')
    })

    output$PFCPlot <- renderPlot({
        req(input$selected_tab == "PFC Plot")

        probs1 <- subset(dataset()$PFC, list(Ethanol_units = input$e1, Daily_cigarettes = input$c1))
        probs2 <- subset(dataset()$PFC, list(Ethanol_units = input$e2, Daily_cigarettes = input$c2))

        ymax <- max(probs1$quantiles, probs2$quantiles, na.rm = TRUE)

        plot(probs1, ylim = c(0, ymax), col = 1:2, legend = FALSE)
        plot(probs2, col = 3:4, add = TRUE, legend = FALSE)

        legend("topleft", legend = c(
            paste("Ethanol_units 1 =", input$e1, ", Daily_cigarettes 1 =", input$c1),
            paste("Ethanol_units 2 =", input$e2, ", Daily_cigarettes 2 =", input$c2)),
            col = c(1, 3), lty = 1, lwd = 2, bty = 'n')
    })
}

# Custom JavaScript to update the browser tab title dynamically
js_code <- "
Shiny.addCustomMessageHandler('updateTitle', function(newTitle) {
    document.title = newTitle;
});
"

app = shinyApp(ui = tagList(
    tags$head(tags$script(HTML(js_code))),  # Include JS for title change
    ui
), server)

runApp(app)