## Get file from site, unzip and change format 

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?", nrows=2075259, stringsAsFactors=FALSE, comment.char="", quote='\"')
unlink(temp)
data$Datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Subset

data_sub <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)

## Convert variables

data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power)
data_sub$Sub_metering_1 <- as.numeric(data_sub$Sub_metering_1)
data_sub$Sub_metering_2 <- as.numeric(data_sub$Sub_metering_2)
data_sub$Sub_metering_3 <- as.numeric(data_sub$Sub_metering_3)

data_sub$Global_reactive_power <- as.numeric(data_sub$Global_reactive_power)

data_sub$Voltage <- as.numeric(data_sub$Voltage)

## Plot

par(mfrow = c(2, 2)) 

with(data_sub, {
        
        plot(Datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", cex=0.2)        
        
        plot(Datetime, Voltage, type="l", xlab="datetime", ylab="Voltage")        

        plot(Datetime, Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
        lines(Datetime, Sub_metering_2, type="l", col="red")
        lines(Datetime, Sub_metering_3, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
        
        plot(Datetime, Global_active_power, type="l", xlab="datetime", ylab="Global_reactive_power (kilowatts)")        
        
})


## Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()