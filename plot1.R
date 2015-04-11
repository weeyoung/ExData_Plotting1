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
png(file ="plot1.png",height=480,width=480)

# plot
hist(data$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

# close the file
dev.off()