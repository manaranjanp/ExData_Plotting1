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
png("plot1.png", width=480, height=480 )

## Create the histogram
hist(pconsume$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency" )

## Close the device
dev.off()