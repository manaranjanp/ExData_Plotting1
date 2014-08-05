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
png("plot4.png", width=480, height=480 )

## Convert the date field from character to calendar data and time
pconsume$ts <- strptime(paste( pconsume$Date, pconsume$Time, sep = " " ),
                        "%d/%m/%Y %H:%M:%S" )

## Create 2x2 panel to draw 4 plots
par(mfrow = c(2, 2))

## Draw all 4 plots
with( pconsume, {
        
## Draw the line plot between global active power and timestamp        
        plot( pconsume$ts, pconsume$Global_active_power, 
              type = "l",
              main = "",
              ylab = "Global Active Power",
              xlab = "" )

## Draw the line plot between Voltage and timestamp        
        plot( pconsume$ts, pconsume$Voltage, 
              type = "l",
              main = "",
              ylab = "Voltage",
              xlab = "datetime" )
        
## Draw the line plot between sub metering 1, 2 & 3 and timestamp
        plot( pconsume$ts, pconsume$Sub_metering_1, 
              type = "l",
              main = "",
              ylab = "Energy sub metering",
              xlab = "" )
        
        lines( pconsume$ts, pconsume$Sub_metering_2, col="red" )
        
        lines( pconsume$ts, pconsume$Sub_metering_3, col="blue" )
        
        legend("topright", "(x,y)", 
               c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
               lty=c(1,1), 
               bty = "n",
               col=c("black", "blue","red"))
        
## Draw the line plot between global reactive power and timestamp        
        plot( pconsume$ts, pconsume$Global_reactive_power, 
              type = "l",
              main = "",
              ylab = "Global_reactive_power",
              xlab = "datetime" )
        
})

## Close the device
dev.off()