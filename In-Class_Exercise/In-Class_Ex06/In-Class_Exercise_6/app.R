pacman::p_load(shiny, tidyverse)
#library(shiny)
#library(tidyverse)

exam <- read_csv("Exam_data.csv")

# Define UI - layout and appearance of app
ui <- fluidPage(
  titlePanel("Pupil Exam Results Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "variable",
        label = "Subject:",
        choices = c("English"="ENGLISH",
                    "Maths"="MATHS",
                    "Science"="SCIENCE"),
        selected = "ENGLISH"),
      
      sliderInput(inputId = "bin",
                  label = "Number of Bins",
                  min = 5,
                  max = 20,
                  value = 10)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)
# Define server logic - contains instructions to build app
server <- function(input, output) {
  output$distPlot <- renderPlot({
    ggplot(exam, aes_string(input$variable)) +
      geom_histogram(bins=input$bin,
                     color="black",
                     fill="light blue")
  })
}

# Run the application - creates the shiny app object (function itself)
shinyApp(ui = ui, server = server)

