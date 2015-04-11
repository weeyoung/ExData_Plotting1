# Read table from txt
data<-read.table("household_power_consumption.txt", header=TRUE, sep = ";", colClasses = "character")

# convert Date and Time variables to Date/Time classes
data$Date <- as.Date(data$Date , "%d/%m/%Y")

# examine how household energy usage varies over a 2-day period in February, 2007
range<-data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")
data<-data[range,]

data$Time <- paste(data$Date, data$Time, sep=" ")
data$DateTime <- strptime(data$Time, "%Y-%m-%d %H:%M:%S")

# Convert Global_active_power to numeric
data$Global_active_power<-as.numeric(data$Global_active_power)

# Output graph to png
png(file ="plot4.png",height=480,width=480)

# 2 x 2
par(mfrow=c(2,2))

# plot 1
plot(data$DateTime, data$Global_active_power,  xlab="", ylab="Global Active Power (killowatts)",type="l")

# plot 2
plot(data$DateTime, data$Voltage, xlab="datetime", ylab="Voltage",type="l")

# plot 3
plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
points(data$DateTime, data$Sub_metering_2, type = "l", col = "red", xlab = "", ylab="")
points(data$DateTime, data$Sub_metering_3, type = "l", col = "blue", xlab = "", ylab="")

legend("topright", 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
	lty = c(1,1,1), col = c("black", "red", "blue"))

# plot 4
plot(data$DateTime, data$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power",type="l")

# close the file
dev.off()