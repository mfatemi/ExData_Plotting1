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
png("plot2.png", width = 480, height = 480)

## plot lines
##use time for y axis to get every point
plot(df$Time, df$Global_active_power,   ylab = "Global Active Power (kilowatts)", xlab="",type="l")

##close file
dev.off()
