library(scales)
library(ggplot2)

mortgageCalculator <- function(property.value,downpayment,duration,interest.rate,property.growth,inflation) {
  
  mortgage <- property.value - downpayment  
  interest.payment <- mortgage * ((1 + interest.rate/12)^(12*duration)-1)
  payment <- (mortgage + interest.payment)/(duration*12)
  break.even <- interest.payment/(12*payment)
  
  balance <-  seq(0,duration*12)*payment - (mortgage + interest.payment)
  property <- property.value*(1 + property.growth)^(seq(0,duration*12)/12)
  value <- (balance + property)/((1+inflation)^(seq(0,duration*12)/12)) 
  v <- data.frame(Years=seq(0,duration*12)/12,Value=value)
  final <- v$Value[length(v$Value)]
  return(data.frame(break.even,payment,final,Years=seq(0,duration*12)/12,Value=value))
}


shinyServer(
  function(input, output) {
    m <- reactive({mortgageCalculator(input$property.value,input$downpayment,input$duration,input$interest.rate,input$property.growth,input$inflation)})
    output$payment <- renderPrint({format(round(m()$payment[1],digits=2),scientific=FALSE)})
    output$break.even <- renderPrint({round(m()$break.even[1],digits=1)})
    output$final <- renderPrint({format(round(m()$final[1],digits=2),scientific=FALSE)})

    output$devplot <- renderPlot({
      ggplot(aes(Years,Value),data=data.frame(Years=m()$Years,Value=m()$Value))+coord_cartesian(ylim = c(min(0,min(m()$Value)), max(m()$Value*1.1)))+
        geom_step(lwd=2)+scale_y_continuous(name="Inflation-adjusted Value of Investment",
                                            labels=comma)+geom_vline(xintercept=m()$break.even[1],lwd=1,col='red')+
        geom_hline(yintercept=input$downpayment,lwd=1,col='black',lty=2)+
        geom_hline(yintercept=input$property.value,lwd=1,col='black',lty=2)+ labs(title="Development of investment adjusted by inflation")
      
      
    })
    
    
    
  }
)




