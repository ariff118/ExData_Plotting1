## Set working directory
## Make changes accordingly respective to your working directory on your comuter
setwd ("C:/Users/MSI/Desktop/wd_R")
getwd()

## calculate a rough estimate of how much memory the dataset will require 
## in memory before reading into R.
raw_bytes <- 2075259 * 9 * 8
raw_MB <- round(raw_bytes / (2^20), digit = 2)
raw_GB <- round(raw_MB / 1000, digit = 3)
paste("Rough estimates of required memory is approximately", raw_MB,"MB or", raw_GB,"GB")

## Getting and reading dataset, then assign to a variable name "alldata"
alldata <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
alldata$Date <- as.Date(alldata$Date, format="%d/%m/%Y")
head(alldata$Date) 

## Subsetting the data
## Select only the required subset from the original data set
data <- subset(alldata, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(alldata)
head(data)

## Converting dates 
## The as.Date methods accept character strings, factors, logical NA and 
##    objects of classes "POSIXlt" and "POSIXct". (The last is converted 
##    to days by ignoring the time after midnight in the representation 
##    of the time in specified time zone, default UTC.) 
## as.POSIXct and as.POSIXlt return an object of the appropriate class
datetime <- paste(as.Date(data$Date), data$Time)
head(datetime)
data$Datetime <- as.POSIXct(datetime)
head(data$Datetime)

## Construct the plot and save it to a PNG file with a width of 480 pixels
## and a height of 480 pixels.
## Plot 1
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()