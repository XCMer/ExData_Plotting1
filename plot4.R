# This is the same as plot1.R
smallData <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", nrows=100)
colClasses <- sapply(smallData, class)
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses=colClasses)

# This is the same as plot1.R
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# This is the same as plot2.R
data$DateTime <- strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# Draw the plot in the png file, with the required dimension of 480x480. It's not required
# to specify the width and height, since 480 is the default. But I've added it here for clarity.
png("plot4.png", width=480, height=480, units="px")

# Set 2x2 plot
par(mfrow=c(2,2))

# 1st plot: Global Active Power
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# 2nd plot: Voltage
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# 3rd plot: Sub metering
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(list(x=data$DateTime, y=data$Sub_metering_2), col="red")
lines(list(x=data$DateTime, y=data$Sub_metering_3), col="blue")
legend("topright", col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty="solid", box.lwd=0)

# 4th plot: Global reactive power
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")

dev.off()
