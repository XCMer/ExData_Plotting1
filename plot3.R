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
png("plot3.png", width=480, height=480, units="px")

# Plot sub metering 1 first
plot(data$DateTime, data$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering")

# Second and third metering are appending using the lines function
# It's important to wrap our x and y inside a list, because x is of type
# POSIXlt which is itself a list, and the lines function gets confused.
lines(list(x=data$DateTime, y=data$Sub_metering_2), col="red")
lines(list(x=data$DateTime, y=data$Sub_metering_3), col="blue")

# Add legends
# I've added extra spaces to the first legend item or else R partially puts the text outside
# the right border
legend("topright", col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty="solid")

dev.off()
