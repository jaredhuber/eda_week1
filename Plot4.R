#Load relevant libraries
library(dplyr)
library(readr)
library(lubridate)

#Specify and download datafile
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(file_url, temp, mode="wb")

#Unzip datafile and read in as a large dataframe
unzip(temp, "household_power_consumption.txt")
p_c <- read_delim("household_power_consumption.txt", delim = ";")
unlink(temp)

#subset the dataframe to only look at Feb 1 and Feb 2
feb_days = subset(p_c, (dmy(Date) == "2007-02-01") | (dmy(Date) == "2007-02-02"))

feb_days$date_time=(dmy_hms(paste(feb_days$Date, "00:00:00")) + (feb_days$Time))

#Create and save plot
png(file="Plot4.png",width=480,height=480)

#sets up the canvas
par(mfcol=c(2,2))

#Plot upper left Datetime vs GAP
plot(x= feb_days$date_time,
     y=feb_days$Global_active_power, 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

#Plot lower left multiplot
plot(x= feb_days$date_time,
     y=feb_days$Sub_metering_1, 
     type="l",
     ylab="Energy sub metering",
     xlab="")
lines(x= feb_days$date_time,
     y=feb_days$Sub_metering_2, 
     col="red")
lines(x= feb_days$date_time,
      y=feb_days$Sub_metering_3, 
      col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), bty = "n")

#Plot upper right Datetime vs Voltage
plot(x= feb_days$date_time,
     y=feb_days$Voltage, 
     type="l",
     ylab="Voltage",
     xlab="datetime")

#Plot lower right Datetime vs GRP
plot(x= feb_days$date_time,
     y=feb_days$Global_reactive_power, 
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime")

dev.off()

