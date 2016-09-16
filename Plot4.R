# Coursera Exploratory Data Analysis Peer Graded Assignment: Course Project 1
#*******************************************************************************
# Plotting the electric power consumption data from UCI Irvine Machine Learning Repository http://archive.ics.uci.edu/ml/
# Plot 4
#*******************************************************************************
# download .txt file to directory ./data , unzip the file
library(dplyr)
if (!file.exists("./data/household_power_consumption.txt")){
        if (!file.exists("./data/power_consumption.zip")){
                if (!file.exists("./data")){dir.create("./data")}   
                fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(fileUrl, destfile="./data/power_consumption.zip", method = "curl")
                unzip(zipfile = "./data/power_consumption.zip", exdir = "./data/")
        } else {
                unzip(zipfile = "./data/power_consumption.zip", exdir = "./data/")
        }
}
# read the data from file
hhdata <- read.csv("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?", "NA"), 
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Combine Date and Time column to a timestamp
hhdata <- mutate(hhdata, timestamp=as.POSIXct(strptime(paste(Date, Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")))
hhdata <- select(hhdata, timestamp, Global_active_power:Sub_metering_3)
#Tidy data now

#Subset of data
hhpart <- filter(hhdata, timestamp >= "2007-02-01" & timestamp <"2007-02-03")

#Plot 4
par(mfcol = c(2, 2))
with(hhpart, plot(timestamp, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l"))

with(hhpart, plot(timestamp, Sub_metering_1, col = "black", ylab = "Energy sub metering", xlab = "", type = "l"))
with(hhpart, lines(timestamp, Sub_metering_2, col = "red"))
with(hhpart, lines(timestamp, Sub_metering_3, col = "blue"))
legend("top", lty = "solid", cex = 0.7, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(hhpart, plot(timestamp, Voltage, ylab = "Voltage", xlab = "datetime", type = "l"))

with(hhpart, plot(timestamp, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l"))

dev.copy(png, file="Plot4.png", width = 480, height = 480, units = "px", type = "quartz")
dev.off()
