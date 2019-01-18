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
    
##generate plot 3 (datetime vs sub_metering classes-3 colors)
    
  #get range for x and y axis
    xrange<-range(subpower$timexct)
    yrange<-range(subpower$Sub_metering_1)
    
  #set up plot and add lines
    par("mar")
    par(mar=c(2,5,2,2))
    plot(xrange, yrange, type="n", ylab="Energy sub metering")
    
    lines(subpower$timexct, subpower$Sub_metering_1, col="black")
    lines(subpower$timexct, subpower$Sub_metering_2, col="red")
    lines(subpower$timexct, subpower$Sub_metering_3, col="blue")
    
  #add a legend
    legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty="solid", x.intersp=0.5, y.intersp = 0.6)
    
  #export figure to png file
    dev.copy(png, file="plot3.png")
    dev.off()
    