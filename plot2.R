# This is the same as plot1.R
smallData <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", nrows=100)
colClasses <- sapply(smallData, class)
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses=colClasses)

# This is the same as plot1.R
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# We create a new column called DateTime, by first concatenting the strings in "Date" column
# and "Time" column, and then using strptime on the result.
# Since we're only working on data for the two days, it's much more faster to do it here.
data$DateTime <- strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# Draw the plot in the png file, with the required dimension of 480x480. It's not required
# to specify the width and height, since 480 is the default. But I've added it here for clarity.
png("plot2.png", width=480, height=480, units="px")

# The reference plot does not have a "main" title, but I've added it here
plot(data$DateTime, data$Global_active_power, type="l",
     xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
