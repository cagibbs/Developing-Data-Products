library(shiny)
require(markdown)

# Define UI for application
shinyUI(fluidPage(
  
  # App title
  titlePanel("Countries with over 1 million annual malaria cases reported 2000-2012"), 
  
  # Sidebar with controls to select the variable to plot against
  # number of malaria cases and checkbox for including outliers

  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Variable:",
                  c("Region" = "REGION..DISPLAY.",
                    "Country"= "COUNTRY..DISPLAY.",
                    "Year" = "YEAR..CODE.")),
      
      checkboxInput("outliers", "Show outliers", FALSE)
      
      
    ),
    
    # Show the caption and plot of the requested variable against
    # number of cases of malaria
    mainPanel(
      h3(textOutput("caption")),
      
      plotOutput("NumericPlot", width = "100%"),
    
      tabsetPanel(tabPanel("About", mainPanel(includeMarkdown("about.md") 
      )
      )
      )
    )
  )
)
)