# the goal of the project : Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007
# download file only in part 1
if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="rawData.zip") 
    unzip("rawData.zip")
}


## Reading the data
##read table
df <- read.table("household_power_consumption.txt", sep=";", header=T, colClasses=c("character", "character", rep("numeric", 7)), na.strings="?") 

##head(df)

##filter data first
df<-df[(df$Date=="1/2/2007" | df$Date=="2/2/2007" ),]

## convert date
df$Date <- as.Date(df$Date , "%d/%m/%Y")
## create date time string
df$Time <- paste(df$Date, df$Time, sep=" ")

##convert time
df$Time <- strptime(df$Time, "%Y-%m-%d %H:%M:%S")

## create png file
png("plot4.png", width = 480, height = 480)

# plot matrix 2 by 2
par(mfrow = c(2, 2))

## plot 

#first row
plot(df$Time, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(df$Time, df$Voltage, xlab = "datetime", type = "l", ylab = "Voltage")


#secound row
plot(df$Time, df$Sub_metering_1,   ylab="Energy sub metering", xlab="",type="n"
     , ylim=c(min(c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)),
              max(c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)))
     )

lines(df$Time, df$Sub_metering_1,col="black")
lines(df$Time, df$Sub_metering_2,col="red")
lines(df$Time, df$Sub_metering_3,col="blue")


legend("topright", lwd=1,  col=c("black", "red", "blue"),  
       legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3")) 

plot(df$Time, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

##close file
dev.off()
