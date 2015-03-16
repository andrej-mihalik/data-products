shinyUI(pageWithSidebar(
  headerPanel("Mortgage Calculator"),
  sidebarPanel(
    numericInput('property.value', 'Property Value', 0, min = 0, step = 1,value=100000),
    numericInput('downpayment', 'Down Payment', 0, min = 0, step = 1,value=20000),
    sliderInput('duration', 'Duration', min=1, max=50, step = 1,value=10,ticks=FALSE),
    numericInput('interest.rate', 'Interest Rate p.a.', 0, min = 0, step = 0.01,value=0.05),
    numericInput('property.growth', 'Growth of Property Value p.a.', 0, min = 0, step = 0.01,value=0.05),
    numericInput('inflation', 'Inflation p.a.', 0, min = 0, step = 0.01,value=0.05),
    h4('How to use this calculator'),
    p('Enter the value of the property you would like to finance by a mortgage, the down payment you already deposited, duration of the loan contract in years, annual interest rate, estimated annual growth of property value as well as annual inflation. In the main panel you will be able to see the graphical development of your investment, your monthly payment, time after which you will have paid the interest on your mortgage as well as the expected value of your property at the time when you will fully own it in adjusted by inflation. The values in the main panel will be automatically re-adjusted using your data. ')
  ),
  mainPanel(
  h4('Monthly Payment'),
  verbatimTextOutput("payment"),
  h4('Years until Interest Payment paid'),
  verbatimTextOutput("break.even"),
  h4('Final Value (Adjusted by Inflation)'),
  verbatimTextOutput("final"),
  plotOutput('devplot'),
  p('The red line represents the point in time when the Interest Payment on your mortgage is paid, the lower dotten line represents your initial down payment, the upper dotted line represents the property value in year 0.')
)
))