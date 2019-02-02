############################################################################
# plot2.R
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
png(filename = "plot2.png",
    width = 480,
    height = 480,
    units = "px")

# create the plot using "base plot"
plot(household$DateTime, household$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Gloabal Active Power (kilowatts)")

# close the device
dev.off()