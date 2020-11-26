setwd("C:/Users/user/Desktop/datascience/power comp data")
powerc<- read.csv(unz('household_power_consumption.zip', "household_power_consumption.txt"), sep = ";")
powerc$Date<- as.Date(powerc$Date, "%d/ %m/ %Y")
#powerc$Time<- strptime(powerc$Time, "%H:%M:%S")
powerc2007<- with(powerc, powerc[(Date >= '2007-02-01' & Date <= '2007-02-02'),])
class(powerc2007$Global_active_power)
powerc2007$Global_active_power<- as.numeric(powerc2007$Global_active_power)
dateandtime <-paste(as.Date(powerc2007$Date), powerc2007$Time)
powerc2007$dateandtime <- as.POSIXct(dateandtime)


png(file="plot3.png", width = 480, height = 480)

with(powerc2007, {
  plot(dateandtime, Sub_metering_1 , type = "l", ylab = "Energy sub metering", xlab="")
  lines(dateandtime, Sub_metering_2, col = "red")
  lines(dateandtime, Sub_metering_3, col = "blue")
}
  )
legend('topright', col = c("black", "red", "blue"), lty = 1, lwd = 2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off()
