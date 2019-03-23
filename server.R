
library(shiny)
library(readxl)
library(plotly)

data <- read_excel("./data/scores.xlsx")
t <- read_excel("./data/time.xlsx")

#t1 = t[, 2:31]
#t2 = t[,32:61]
#t3 = t[,62:91]

d = data
d = d[-c(nrow(d),nrow(d) - 1),]
d = d[order(d$Cumulative, decreasing = 'TRUE'), range(1,length(colnames(data)))]


Test = vector()
for (i in 1:length(colnames(data))-2) {
  Test[i] = paste('Test', i, sep = " ")}

Average = data[length(data[["Roll Number"]]), seq(2,length(colnames(data)) - 1)]
Average = as.numeric(as.vector(Average))

Max = data[length(data[["Roll Number"]]) - 1, seq(2,length(colnames(data)) - 1)]
Max = as.numeric(as.vector(Max))

server <- function(input,output,session) {

  #observe the add click and perform a reactive expression
  observeEvent(input$add,{
    
    x <- as.numeric(input$one)
    
    Marks = data[x,seq(2,length(colnames(data)) - 1)]
    Marks = as.numeric(as.vector(Marks))
    
    t1 = t[x, 2:31]
    t1a = t[nrow(t),2:31]
    t2 = t[x,32:61]
    t2a = t[nrow(t),32:61]
    t3 = t[x,62:91]
    t3a = t[nrow(t),62:91]
    r1 = rbind(t1, t1a)
    r2 = rbind(t2, t2a)
    r3 = rbind(t3, t3a)
    #reactive expression
    output$plot <- renderPlotly({
      plot_ly(x = ~Test, y = ~Marks, name = 'Your Score', type = 'scatter', mode = 'lines+markers')%>%
      add_trace(y = ~Average, name = "Average", mode = 'lines+markers')%>%
      add_trace(y = ~Max, name = "Highest Score", mode = 'lines+markers')})
    
    output$plot1 <- renderPlot({
      barplot(as.matrix(r1),beside = T, col=rgb(0.2,0.4,0.6,0.6), xlab="Question Number", ylab="Time Spent") 
    })
    
    output$plot2 <- renderPlot({
      barplot(as.matrix(r2),beside = T, col=rgb(0.2,0.4,0.6,0.6), xlab="Question Number", ylab="Time Spent") 
    })
    
    output$plot3 <- renderPlot({
      barplot(as.matrix(r3),beside = T, col=rgb(0.2,0.4,0.6,0.6), xlab="Question Number", ylab="Time Spent") 
    })

     output$mytable = renderTable({d})
     })}
  
