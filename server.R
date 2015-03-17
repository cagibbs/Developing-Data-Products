library(shiny)

mdata<-read.csv("malariacases.csv", stringsAsFactors=FALSE, header=TRUE)
#subset country rows with at least 1 million reported malaria cases to make plots easier to read
highm<-(mdata[mdata$Numeric>1e6,])
#subset only Numeric, YEAR..CODE. REGION..DISPLAY, COUNTRY..DISPLAY. 
highm<-highm[,c(7,11,14,17)]


# Define server logic required to plot various variables against the number of malaria cases
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression since it is
  # shared by the output$caption and output$NumericPlot functions
  formulaText <- reactive({
    paste("Numeric ~", input$variable)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against Numeric and
  # only include outliers if requested
  output$NumericPlot <- renderPlot({
    par(mar=c(10,4.5,4.1,2.1))
    boxplot(as.formula(formulaText()), 
            data = highm,
            outline = input$outliers,
            las=2, cex.lab=0.6, col="#DEB997")
  })
})