## install package sqldf, which has a
## function read.csv.sql that allows to read selected rows from file
library( sqldf )

## The script expects the file household_power_consumption.txt to be 
## available in your current working directory. And it reads
## only the rows, which belongs to date 1/2/2007 and 2/2/2007
pconsume <- read.csv.sql( "household_power_consumption.txt", 
        sql = "select * from file where Date=='1/2/2007' or Date=='2/2/2007'", 
        sep=";", header=TRUE )

## Set the device to png with required pixel height and width
png("plot2.png", width=480, height=480 )

## Convert the date field from character to calendar data and time
pconsume$ts <- strptime(paste( pconsume$Date, pconsume$Time, sep = " " ),
                        "%d/%m/%Y %H:%M:%S" )

## Draw the line plot between global active power and timestamp
plot( pconsume$ts, pconsume$Global_active_power, 
      type = "l",
      main = "",
      ylab = "Global Active Power (kilowatts)",
      xlab = "" )

## Close the device
dev.off()