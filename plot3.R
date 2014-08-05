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
png("plot3.png", width=480, height=480 )


## Convert the date field from character to calendar data and time
pconsume$ts <- strptime(paste( pconsume$Date, pconsume$Time, sep = " " ),
                        "%d/%m/%Y %H:%M:%S" )

## Draw the line plot between sub metering 1, 2 & 3 and timestamp
# First plotting with sub metering 1
plot( pconsume$ts, pconsume$Sub_metering_1, 
      type = "l",
      main = "",
      ylab = "Energy sub metering",
      xlab = "" )

# adding sub metering 2
lines( pconsume$ts, pconsume$Sub_metering_2, col="red" )

# adding sub metering 3
lines( pconsume$ts, pconsume$Sub_metering_3, col="blue" )

# adding appropriate legends
legend("topright", "(x,y)", 
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1), 
       col=c("black", "blue","red"))

## Close the device
dev.off()