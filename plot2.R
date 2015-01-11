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

## Convert Global_active_power to numeric

data_sub$Global_active_power <- as.numeric(data_sub$Global_active_power)

## Plot

with(data_sub, {
        plot(Datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
})

## Save to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()