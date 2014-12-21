shinyUI
(
  pageWithSidebar
  (
    headerPanel("Frequency of a System"),
    sidebarPanel
    (
      textInput('generator','Function of t',value='sin(2*pi*2*t)+cos(2*pi*5*t)'),
      numericInput('fs','Sampling Frequency',value=50,min=1),
      checkboxInput('atZero','Plot at 0 Hz',value=TRUE),
      submitButton('Submit')
    ),
    mainPanel
    (
      plotOutput('FFT_Plot')
    )
  )
)