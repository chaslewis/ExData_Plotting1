# Coursera DSS 04 Exploratory Data Analysis
# PA01 (Plotting)

# plot4.R - create PNG of fourth plot (2x2 multiple plots)

# setwd("C:/Users/Administrator/Google Drive/Coursera/DataScienceSpecialization/04-ExploratoryAnalysis/prog/ExData_Plotting1")

# get the raw data if processed data does not exist locally
if (!file.exists("power2day.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile="power.zip")
    unzip("power.zip")
    # read in the big power consumption table; specify column types and NA coding
    power <- read.table("household_power_consumption.txt", sep=';', header=TRUE, 
                        colClasses=c("character", "character", "numeric", "numeric", "numeric", 
                                     "numeric", "numeric", "numeric", "numeric"), na.strings="?")
    
    # make a POSIXct column from date and time columns
    # (would be faster to filter by Date and do this later in smaller table, but this approach
    #   allows for further exploration, e.g., different date & time ranges from full dataset)
    power$datetime <- strptime(paste(power[,1],power[,2]), format="%d/%m/%Y %H:%M:%S")
    
    # extract the two desired days    
    power2day <- power[as.Date(power$datetime) == "2007-02-01" | 
                       as.Date(power$datetime) == "2007-02-02",  ]
    # and save locally (for further exploration, other plots)
    write.csv(power2day, file="power2day.csv", row.names=FALSE)
} else {
    # read in the processed data if it already exists:
    power2day <- read.csv("power2day.csv", header=TRUE, as.is=TRUE, 
                          colClasses=c("character", "character", "numeric", "numeric", "numeric", 
                                       "numeric", "numeric", "numeric", "numeric", "POSIXct"))
}

# get a fresh start with default graphics device and settings
graphics.off()

# open PNG graphics device
png(file="plot4.png")

# set by-column 2x2 multi-plot layout
par(mfcol=c(2,2))

# write Plot 4 to the PNG file

# top left
with(power2day, plot(datetime, Global_active_power, type="l", ylab="Global Active Power", xlab=""))

# bottom left
with(power2day, plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", 
                     xlab="", col="black"))
with(power2day, points(datetime, Sub_metering_2, type="l", col="red"))
with(power2day, points(datetime, Sub_metering_3, type="l", col="blue"))
legend("topright", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

# top right
with(power2day, plot(datetime, Voltage, type="l"))

# bottom right
with(power2day, plot(datetime, Global_reactive_power, type="l"))

# close device
dev.off()
