#Upload raw data
data <- read.csv(choose.files())

#Create and reclasify a few columns
data$Date <- as.Date(data$Date)
data$Year <- year(data$Date)
data$Month <- month(data$Date)
data$Week <- week(data$Date)
#data <- tidyr::separate(data, Time, into = c("Hour", "Minute"), sep = ":")
data$Hour <- as.numeric(data$Hour)
data$Count <- as.numeric(data$Count)

#Filter out the non-species taxa (hybrid, subspecies, genus, etc.) and place it into a new dataframe.
data <- dplyr::filter(data, State.Province == "US-IL", County == "Cook", Year == "2020")
data2 <- dplyr::filter(data, str_detect(Common.Name, "Domestic")==F)
data2 <- dplyr::filter(data2, str_detect(Common.Name, "Established Feral")==F)
data2 <- tidyr::separate(data2, "Common.Name", into = c("Common.Name", "Subspecies"), sep = " \\(")
data2 <- dplyr::filter(data2, str_detect(Common.Name, " sp.")==F)
data2 <- dplyr::filter(data2, str_detect(Common.Name, "/")==F)
data2 <- dplyr::filter(data2, str_detect(Common.Name, " x ")==F)
