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
