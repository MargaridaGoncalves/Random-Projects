# PART 1: How to Clean the workspace
# Clear variables
rm(list=ls())
#Get path
path<-getwd(); path
# Set path
setwd(path)

#PART 2: HOW TO CREATE COLUMNS WITH FUNCTIONS
# Call dataset from R 
mydata1 <- as.data.frame(islands)
str(mydata1)

# Create a column uses the values from another column

mydata1$group <- with(mydata1, ifelse(islands >= 0 & islands <= 100, "Small", ifelse(islands > 100 & islands <= 1000, "Medium", "Big")))
mydata1$group <-factor(mydata1$group)
mydata1$group

#ou criar grupos com numeros
mydata1$group2 <- with(mydata1, ifelse(islands >= 0 & islands <= 100, 1, ifelse(islands > 100 & islands <= 1000, 2, 3)))
mydata1$group2 <-factor(mydata1$group2)
mydata1$group2


#PART 2: HOW TO FILTRATE SPECIFIC DATA FROM TABLES

NewTable = mydata1[mydata1$group == "Small",]

#PART 3: VERIFY HOW MANY Small Medium Big are in the table

a = length((which(mydata1$group=="Small")))
b = length((which(mydata1$group=="Medium")))
c = length((which(mydata1$group=="Big")))

#PART 4: Create a table of classification by hand
M <- as.table(rbind(c(170,30), c(194, 16)))
dimnames(M) <- list(Tratamento = c("Standard","Novo"), Presença_doença=c("NAO", "Sim"))
M

#PART 5: Remove sprecific letters or words from the row names and colnames

# In this example we wanted to remove the word subject given that the rownames were like Subject0123, Subject133...
row.names(SampleInfo) <- sub("Subject", "", row.names(SampleInfo)) 
SampleInfo

# In this example we wanted to remove the letter S given that the column names were like S89, S33...
colnames(expression.matrix1) <- sub("S", "", colnames(expression.matrix1))
expression.matrix1

#PART 6: Save the new data frames in  readr format
# Here the dataframe is designed as counts.table
write.table(counts.table, file='C:/Users/Acer/OneDrive/Dataset 3/count_table.txt', sep = "\t",col.names = NA)
write.table(counts.table, 'count_table.txt', sep = "\t",col.names = NA) # if i added the set path code (Part 1)

#PART 7: Save as Rdata file

save(counts.table, file = "Counts.RData")
# In the document to call this file you just need to code:
load('Counts.RData')

#PART 7: Save as excel file
library(writexl)
write_xlsx(final, "FinaldataDE.xlsx")

#PART 9: Remove rownames from dataset

library(dplyr)
mydata1 = mydata1 %>% `rownames<-`( NULL )

# PART 10: dev.off() 
## save images with high quality
 ## pdf

pdf("province.pdf",         # File name
    width = 10, height = 4, # Width and height in inches
    bg = "white",          # Background color
    paper = "A4") 

p <- ggplot(...)

dev.off()

# or with ggsave

p <- ggplot(...)
ggsave('plot.png', p, bg='transparent')

# PART 11:
## Change a specific number in the vector

vector <- c(1, 2, 3, 1, 4, 5, 1) # Create a sample vector
index <- which(vector == 1)[1] # Find the index of the first occurrence of 1
vector[index] <- -1 # Change the value at that index to -1

# PART 12: Subset columns and rows with a specific string or name

miRNA_info <- miRNA_info[startsWith(miRNA_info$sample, "EXO"),] # for rows
miRNA_info <- miRNA_info[endsWith(miRNA_info$sample, "PL"),] # for rows

head(miRNA_raw)

a <- miRNA_raw[grepl("EXO", names(miRNA_raw), fixed=TRUE)] # for columns
a <- a[endsWith(names(a), "PL")] # for columns
