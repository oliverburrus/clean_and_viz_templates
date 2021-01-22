#Note: work in progress, does not yet cover all variables.

#load required packages
library(dplyr)
library(lubridate)

#Create "Month" vector.
month <- seq(1, 12)

#Run the "for" loop
for(i in 1:length(month)){
  d <- filter(data2, Month == month[i])
  if(i == 1){
    Checklists <- length(unique(d$Submission.ID))
    Species <- length(unique(d$Common.Name))
    e <- filter(d, is.na(Count) == F)
    Count <- sum(e$Count)
    Locations <- length(unique(d$Location.ID))
  } else{
    Checklistsx <- length(unique(d$Submission.ID))
    Checklists <- rbind(Checklists, Checklistsx)
    Speciesx <- length(unique(d$Common.Name))
    Species <- rbind(Species, Speciesx)
    e <- filter(d, is.na(Count) == F)
    Countx <- sum(e$Count)
    Count <- rbind(Count, Countx)
    Locationsx <- length(unique(d$Location.ID))
    Locations <- rbind(Locations, Locationsx)
  }
}
month <- data.frame(month, Checklists, Species, Count, Locations)
month$month_str <- month(month$month, label = T)
