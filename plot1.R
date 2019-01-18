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

##generate plot 1 (red histogram of Global active power)
  library(datasets)
    hist(subpower$Global_active_power, xlab="Global Active Power (kilowatts)", ylab = "Frequency", ylim=c(0,1200), main = "Global Active Power", col="red")

#export figure to png file
  dev.copy(png, file="plot1.png")
  dev.off()