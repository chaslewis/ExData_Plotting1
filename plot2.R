# Coursera DSS 04 Exploratory Data Analysis
# PA01 (Plotting)

# plot2.R - create PNG of second plot (Global Active Power vs time)

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

# create Plot 2 in the default device (screen)    
with(power2day, plot(datetime, Global_active_power, type="l", 
                     ylab="Global Active Power (kilowatts)", xlab=""))

# write plot out to PNG file (default dims 480px X 480px)
dev.copy(png, file="plot2.png")
dev.off()
