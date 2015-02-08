
readeu <- function(file = "household_power_consumption.txt")
{
    temp <- read.table(file, header = TRUE, sep = ";", na.strings = "?", nrows = 1);
    data <- read.table(file, header = TRUE, sep = ";", na.strings = "?", skip = 66636, nrows = 2880);
    
    # set correct column names
    names(data) <- names(temp)
    
    data$Time <- paste(data$Date, data$Time)
    
    data$Date <- as.Date(data$Date, "%d/%m/%Y");
    
    data$Time <- strptime(data$Time, "%d/%m/%Y %H:%M:%S")
    
    data  
}

# Draws global active power hostogram
plot1 <- function(file = "household_power_consumption.txt")
{
    print("Reading electric data...")
    # load data
    eudata <- readeu(file)
    
    print("Plotting data...")
    
    # create png device for plotting
    png(filename = "plot1.png", width = 480, height = 480, units = "px")
    
    hist(eudata$Global_active_power, col = "red", main = "Global Active Power",
         xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

    # done plotting, close device
    dev.off()
    
    print("Done plotting data. plot1.png file is ready to view")
}