# Coursera DSS 04 Exploratory Data Analysis
# PA01 (Plotting)

# plot3.R - create PNG of third plot (Multiple Sub-metering series vs time)

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
    # (would be more efficient to filter by Date and do this later in smaller table, but this
    #   approach allows for further exploration, e.g., different date & time ranges from full dataset)
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

# font size in example graphics smaller than default
par(ps=12)

# create Plot 3 in the default device (screen)    
with(power2day, plot(datetime, Sub_metering_1, type="l", ylab="Energy sub metering", 
                     xlab="", col="black"))
with(power2day, points(datetime, Sub_metering_2, type="l", col="red"))
with(power2day, points(datetime, Sub_metering_3, type="l", col="blue"))
legend("topright", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# write plot out to PNG file (default dims 480px X 480px)
dev.copy(png, file="plot3.png")
dev.off()
