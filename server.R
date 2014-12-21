library(shiny)

shinyServer
(
  function(input, output)
  {
    output$FFT_Plot <- renderPlot(
    {
      # Inputs
      fs <- input$fs
      atZero <- input$atZero
      generator <- input$generator
      
      # The data
      t <- seq(0,1,(1/fs))
      data <- eval( parse( text=generator ) )
      fft_data <- fft( data )
      n <- length( fft_data )
      fft_data <- ( fft_data/n )[1:((n-1)/2+1)]
      power <- Mod(fft_data)
      freq <- seq(0,fs/2)
      if( !atZero )
      {
        power <- power[2:length(power)]
        freq <- freq[2:length(freq)]
      }
      
      # Cut off
      cutoff <- max( power ) - 0.25*diff( range( power ) )
      values <- freq[ power>cutoff ]
      fc <- na.omit( values )
      power_fc <- sapply( fc, function(x) power[freq==x])
      
      # Plot the power spectrum
      xlim <- c(0,fs/2)
      ylim <- c(0,max(power,na.rm=TRUE))
      par( mar=c(4,4,2,0) )
      plot( freq, power, type='l', xlab="Frequency (Hz)", ylab="Power",
            main="Power Spectrum", xlim=xlim, ylim=ylim,
            cex.lab=1.25, cex.main=1.25 )
      # The system frequencies
      points( fc, power_fc, col="red", pch=16 )
      legend( "topright", c("Frequency of","the System",paste(fc,"Hz")), bty='n' )
    } )
  }
)