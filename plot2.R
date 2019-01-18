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
    
##generate plot 2 (Kilowatts of global active power over time between feb 1 and 2, 2007)
    
  #get range for x and y axis
    xrange<-range(subpower$timexct)
    yrange<-range(subpower$Global_active_power)
    
  #set up plot and add lines
    par("mar")
    par(mar=c(2,5,2,2))
    plot(xrange, yrange, type="n", ylab="Global Active Power (kilowatts)")
    lines(subpower$timexct, subpower$Global_active_power)
    
  #export figure to png file
    dev.copy(png, file="plot2.png")
    dev.off()
    