#Requires data2 df

Species <- table(data2$Common.Name)%>%
  as.data.frame()
Species <- Species[order(-Species$Freq),]
