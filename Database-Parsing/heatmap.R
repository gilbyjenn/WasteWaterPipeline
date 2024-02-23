### R script to create heatmap of plant pathogens identified in wastewater metagenome
### Jennifer Gilby, Dr. Cynthia Gibas & Dr. Jessica Schlueter Lab UNC Charlotte


# install packages
install.packages("reshape2")
install.packages('dplyr')

# Libraries
library(ggplot2)
library(reshape2)
library(magrittr)
library(dplyr)
library(tidyr)

# Import and reconfigure the data
data <- read.csv(file = '/Users/jennifergilby/viromeProject/NHpathsMerged_fractions.tsv', sep = '\t', header=TRUE)

  # set species names as row names/index 
rownames(data) <- data$name
data <- subset(data, select = -name)
data
row.names(data)

# transform data
data.long <- pivot_longer(data = data, 
                          cols = -c(name),
                          names_to = "Sample_ID", 
                          values_to = "Abundance")




# Heatmap 
data.heatmap <- ggplot(data = data.long, mapping = aes(x = Sample_ID, y = name, fill = Abundance)) +
  geom_tile() +
  xlab(label = "Sample")

data.heatmap


######## PLANT PATHS ONLY ###########

# Import and reconfigure the data
data2 <- read.csv(file = '/Users/jennifergilby/viromeProject/plantPathsMerged_fractions.tsv', sep = '\t', header=TRUE)

# remove the two non-plant viruses 
data2= data2[data2$name != 'Human mastadenovirus D', ]
data2= data2[data2$name != 'Severe acute respiratory syndrome-related coronavirus', ]

# transform data
data2.long <- pivot_longer(data = data2, 
                          cols = -c(name),
                          names_to = "Sample_ID", 
                          values_to = "Abundance")




# Heatmap 
data2.heatmap <- ggplot(data = data2.long, mapping = aes(x = Sample_ID, y = name, fill = Abundance)) +
  geom_tile() +
  scale_fill_gradient2(low = "#FFFFFF",
                       high = "#FF8000")+
  
  xlab(label = "Sample") +
  ylab(label = "Species Name") +
  labs(title="Relative Abundance of Plant Pathogens in NC Wastewater")

data2.heatmap


