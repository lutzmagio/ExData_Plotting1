############################################################################
# plot4.R
############################################################################

# ----- load data -----

# get names
household_names <- read.table("household_power_consumption.txt",
                              na.strings = "?",
                              nrows = 1,
                              sep = ";",
                              stringsAsFactors = FALSE
)

# get desired data for 2007-02-01 and 2007-02-02
household <- read.table("household_power_consumption.txt",
                        na.strings = "?",
                        skip = 1+66636,
                        nrows = 2*24*60,
                        sep = ";",
                        stringsAsFactors = FALSE
)

# assign column names to data.frame
colnames(household) <- household_names[1, ]

# ----- Convert Date and time to R Date/Time class -----

library(lubridate)

# make new column for date / time objects
household$DateTime <- dmy_hms(paste(household$Date,
                                    household$Time, sep = " "))

# remove Date and Time column since they will not be needed anymore
household <- household[ , 3:length(colnames(household))]

# ----- Make plot -----

# open new device
png(filename = "plot4.png",
    width = 480,
    height = 480,
    units = "px")

# define plot style two rows two columns
par(mfrow = c(2,2))

# -- plot(1,1)
plot(household$DateTime, household$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Gloabal Active Power")

# -- plot(1,2)
plot(household$DateTime, household$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# -- plot(2,1)

plot(household$DateTime, household$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
points(household$DateTime, household$Sub_metering_1,
       type = "l",
       col = "black")
points(household$DateTime, household$Sub_metering_2,
       type = "l",
       col = "red")
points(household$DateTime, household$Sub_metering_3,
       type = "l",
       col = "blue")
legend("topright",
       lty = c(1, 1, 1),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       box.lty = 0,
       inset = .01)

# -- plot(2,2)
plot(household$DateTime, household$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")


# close the device
dev.off()