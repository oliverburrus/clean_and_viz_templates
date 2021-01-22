#Note: work in progress.

library(ggplot2)

#Checklists by month, use month df
ggplot(data = month)+
  geom_bar(aes(x = month_str, y = Checklists, fill = Species), stat = "identity") +
  xlab("Month")+
  geom_hline(yintercept = mean(month$Checklists), size = 1.5, color = "dark green", alpha = .7)+
  labs(title = "Checklists by Month", caption = "The green line denotes the mean number of checklists in a month. Color by species per month.")
  
#Species by month, use month df
ggplot(data = month)+
  geom_bar(aes(x = month_str, y = Species, fill = Locations), stat = "identity") +
  xlab("Month")+
  geom_hline(yintercept = mean(month$Checklists), size = 1.5, color = "dark green", alpha = .7)+
  labs(title = "Species by Month", caption = "The green line denotes the mean number of species in a month. Color by locations visited per month.")
  
#Top 10 most observed species, use Species df
ggplot(data = Species[1:10,])+
  geom_bar(aes(x = reorder(Var1,-Freq,sum), y = Freq, fill = Freq), stat = "identity") +
  xlab("Species")+
  ylab("Observations")+
  labs(title = "Top 10 Most Observed Species")+
  theme(legend.position = "none", axis.text.x = element_text(size = 10, angle = 35, , hjust = 1))
  
#Individual birds seen by month, use month df
ggplot(data = month)+
  geom_bar(aes(x = month_str, y = Count, fill = Checklists), stat = "identity") +
  xlab("Month")+
  ylab("Number of individual birds")+
  geom_hline(yintercept = mean(month$Count), size = 1.5, color = "dark green", alpha = .7)+
  labs(title = "Individual birds by Month", caption = "The green line denotes the mean number of individual birds seen in a month. Color by number of checklists per month.")
  
#Individual birds seen by date, use data2 df
ggplot(data = data2)+
  geom_smooth(aes(x = Date, y = Count)) +
  xlab("Month")+
  ylab("Number of individual birds")+
  labs(title = "Mean individual birds seen per day", caption = "Note: this is a smoothed line graph, it may not denote real values seen on a given day.")

#Species seen by date, use data2 df
ggplot(data = data2)+
  geom_smooth(aes(x = Date, y = Freq)) +
  xlab("Month")+
  ylab("Number of species")+
  labs(title = "Mean species seen per day", caption = "Note: this is a smoothed line graph, it may not denote real values seen on a given day.")

#Species by distance travelled, if you need to remove outliers (you likely will), create a new df and filter out them, if not use data2 df.
data3 <- filter(data2, Submission.ID != {outlier Sub_IDs})
ggplot(data = data3)+
  geom_point(aes(x = Distance.Traveled..km., y = Freq), color = "blue") +
  geom_smooth(aes(x = Distance.Traveled..km., y = Freq), size = 2, color = "red")+
  xlab("Distance Traveled (km)")+
  ylab("Number of species")+
  labs(title = "Species seen per traveling checklist by distance covered", caption = "Note: the red line is a smoothed line graph, it may not denote real values seen. Some outlier values purged.")


#Treemap
##Upload Clements checklist, load required packages, and update Species df.
Clements <- read.csv("https://github.com/oliverburrus/clean_and_viz_templates/raw/main/eBird-Clements-v2019-integrated-checklist-August-2019.csv")
colnames(Species) <- c("Species", "Obs")
Species <- merge(Species, Clements, by.x = "Species", by.y = "English.name")
Species <- tidyr::separate(Species, scientific.name, into = c("Genus", "Species_sci"), " ")
library(treemap)
library(d3treeR)
##Make the base treemap.
p <- treemap(Species,
             index=c("order","family", "Genus", "Species"),
             vSize="Obs",
             type="index",
             palette = "Set2",
             fontsize.labels = 10,
             bg.labels=c("white"),
             overlap.labels = 0,
             align.labels=list(
               c("center", "center"), 
               c("right", "bottom")
             )  
)            
##make it interactive
inter <- d3tree2(p ,  rootname = "Aves")
inter
