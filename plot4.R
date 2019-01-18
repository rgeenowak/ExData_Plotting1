getwd()
setwd("C:/Users/rnowak/Documents/Coursera/explor")


##import the household_power_consumption text- subset only thoe between feb 1 and feb2 of 2007
  library(data.table)
    power<- fread("household_power_consumption.txt", na.string="?")
    #2075259 observations, 10 variables
    power[, datetime := as.Date(paste(Date,Time),format ="%d/%m/%Y %H:%M:%S")]
    head(power)
    names(power)
  library(dplyr)
    subpower<-filter(power, datetime >=as.Date("2007-02-01 00:00:00"), datetime< as.Date("2007-02-03 00:00:00"))
    subpower<-arrange(subpower, datetime)
    #2880 observations, 10 variables

    ##make x axis variable of date and time
    subpower$x<-paste(subpower$Date,subpower$Time)
    subpower$timex<-strptime(subpower$x, "%d/%m/%Y %H:%M:%S")
    subpower$timexct<-as.POSIXct(subpower$timex)
    
##make plot 4(includes 4 graphs)

    #plot 1: kilowatts of active power over feb 1-2
    #plot 2: voltage over feb 1-2
    #plot 3: energy by sub-metering class
    #plot 4: kilwatts of reactive power over feb 1-2

  par(mfrow=c(2,2), par(mar=c(4,4,2,1)))
    with(subpower, {
        xrange<-range(subpower$timexct)
        yrange<-range(subpower$Global_active_power)
      plot(xrange, yrange, type="n", xlab="", ylab="Global Active Power")
        lines(subpower$timexct, subpower$Global_active_power)
      plot(timexct, Voltage, type="n", ylab="Voltage", xlab="datetime")
        lines(timexct, Voltage)
        xrange1<-range(subpower$timexct)
        yrange1<-range(subpower$Sub_metering_1)
      plot(xrange1, yrange1, type="n", xlab="", ylab="Energy sub metering")
        lines(timexct, Sub_metering_1, col="black")
        lines(timexct, Sub_metering_2, col="red")
        lines(timexct, Sub_metering_3, col="blue")
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty="solid", cex=0.8, x.intersp=0.5, y.intersp = 0.6)
      plot(timexct, Global_reactive_power, type="n", ylab="Global_reactive_power", xlab="datetime")
        lines(timexct, Global_reactive_power)
    })
    
  #export figure to png file
      dev.copy(png, file="plot4.png")
      dev.off()
