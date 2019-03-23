# Load the shiny package
library(shiny)
library(plotly)
# Define UI for the shiny application here
shinyUI(fluidPage(
  titlePanel(img(src='logo1.png', align = "left")),
  
  #number input form
  sidebarLayout(
    sidebarPanel(
      p("Please enter your NITovators Roll Number to generate test score analysis."),
      textInput("one", "Roll Number"),
      actionButton("add", "Generate Report"),
      p("Score Analyzer is a product of NITovators®")
      #includeHTML("C:/Users/Admin/Desktop/pROJECTS/R/login/data/static.html")
    ),

    # Show result
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotlyOutput("plot")),
                  tabPanel("Rank List", tableOutput("mytable")),
                  tabPanel("Time Analysis", plotOutput("plot1"), plotOutput("plot2"), plotOutput("plot3") )
                  )
    
      
      
    )
  )
))