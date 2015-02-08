
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
plot4 <- function(file = "household_power_consumption.txt")
{
    print("Reading electric data...")
    # load data
    eudata <- readeu(file)
    
    print("Plotting data...")
    
    # create png device for plotting
    png(filename = "plot4.png", width = 480, height = 480, units = "px")
    
    # need to plot 4 separate graphs - devide into 2x2 board
    par(mfrow = c(2,2))
    
    # Global Active Power v/s Time
    with(eudata, plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
    
    # Volage v/s Time
    with(eudata, plot(Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
    
    # Enegry Sub metering v/s Time
    
    with(eudata, plot(Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
    
    with(eudata, points(Time, Sub_metering_1, type = "l", col = "black"))
    with(eudata, points(Time, Sub_metering_2, type = "l", col = "red"))
    with(eudata, points(Time, Sub_metering_3, type = "l", col = "blue"))
    
    legend("topright", pch = "_", col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # Global Reactive Power v/s Time
    with(eudata, plot(Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
    
    # done plotting, close device
    dev.off()
    
    print("Done plotting data. plot4.png file is ready to view")
}