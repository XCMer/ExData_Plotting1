# To make loading faster, we'll first read 100 lines of the txt file.
# Then, we'll get a list of columnClasses for each column on the basis of those 100 rows.
# Finally, we'll load all the data while specifying the columnClasses.
# This approach is mentioned in the R-Programming course as well as Dr. Peng's book on
# R-Programming.
# For me, it did noticably reduce the loading time.
smallData <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", nrows=100)
colClasses <- sapply(smallData, class)
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", colClasses=colClasses)

# We only need to keep those rows that have Date == "1/2/2007" | Date == "2/1/2007". There is no leading
# zeroes in the day/month in the file. We will not convert the Date column this early into Date/Time classes,
# since it's costly to do that. We'll first discard the rows we're not going to use.
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# Draw the histogram in the png file, with the required dimension of 480x480. It's not required
# to specify the width and height, since 480 is the default. But I've added it here for clarity.
png("plot1.png", width=480, height=480, units="px")

hist(data$Global_active_power, col="red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
