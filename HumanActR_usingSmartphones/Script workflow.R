#Week 4 Getting and cleaning data Assigment Project
###Step 1 Merging test and training sets
library(dplyr)
#Assig working directory
setwd("C:/Users/user/Desktop/datasciencecoursera/Getting and cleaning data assigment/Data")

#files data object into R
filestestinertial <- list.files(path = "test/", pattern = "*.txt", full.names = T)
filestraininertial <- list.files(path = "train/", pattern = "*.txt", full.names = T)

#Read the specified files into tables
test.inertials <- sapply(filestestinertial, read.table, simplify=FALSE) %>% 
      bind_cols
train.inertials <- sapply(filestraininertial, read.table, simplify=FALSE) %>% 
      bind_cols
###Step 4 and 2 
#Read colnames file 
test.names<- fread("features.txt", select= 2)

#Add missing labels
test.names<- rbind(data.frame(V2="subject"), test.names)
test.names<- rbind(test.names, data.frame(V2="activity_labels"))

#Vector to assign column label
test.vectornam<- as.character()
for (i in 1:563){
      test.vectornam = append(test.vectornam, 
                        c(as.character(droplevels(test.names[[1]][i]))))
}
#These changes are to avoid future problems with tag recognition
test.vectornam<- gsub('\\()',"", test.vectornam)
test.vectornam<- gsub('\\-',"_", test.vectornam)
#Assign column names (variables)
colnames(test.inertials)= c(test.vectornam)
colnames(train.inertials)= c(test.vectornam)

#Merging data
fulldata <-rbind(train.inertials, test.inertials)

#Changing dataframe to data.table for better management
fulldata<- data.table(fulldata)


#Create a vector with the names of the columns to select
coltoselect<- as.character()
coltoselect1<- as.numeric()
for (i in 1:563){
      if (fulldata[,grepl("[Mm][Ee][Aa][Nn]",colnames(fulldata)[i])] == TRUE)
            #Use when extract from data.frame coltoselect<- append(coltoselect, c(colnames(fulldata)[i]))
            #Use when data.table to create a vector with positions
            coltoselect1<- append(coltoselect1, i)
}

#Add the column with the activity labels column
coltoselect1<- append(coltoselect1, c(1,563))

###Step 2 
#Selecting mean and std from full data using a vector 
#When fulldata is a data.frame meanstdfulldata<- select(fulldata, c(coltoselect))
#When used the argument .. as ..coltoselect1 is telling that the vector is about positions to select
meanstdfulldata<- fulldata[, ..coltoselect1]

###Step 3
#A vector with the Activity_labels
activity <- c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")

#Replace activity labels numbers as character tag
for (i in 1:6){
      meanstdfulldata<- mutate(meanstdfulldata, activity_labels =gsub(i, activity[i] , meanstdfulldata$activity_labels))
            
}

###step 5
#Tidy data set creation mean per subject & activity using group_by function with two variables
tidy<- group_by(meanstdfulldata, subject, activity_labels)

#Summarize all columns in grouped dataset 
#If you want to summarize certain columns it could be useful summarise_at or summarise_if functions
Finaltable<- summarise_all(tidy, list(mean))

#Write a table 
write.table(Finaltable,file = 'TidydataAngel.txt', row.names = FALSE)

########################################################################
#Other forms to deal with the assigments (more time is needed)
# basic function to retrieve a 
#data.frame value in character form
#as.character(droplevels(test.names[[1]][1]))

#Result =   [1] "subject" if [[]][] are not used the system
#so incorrect assignment values when using as.character function in a data.frame

#change to a list of labels
#test.names1 <- split(test.names, seq(nrow(test.names)))
#Only use in list as.character(droplevels(test.names1[[1]][[1]]))
#as.character(droplevels(test.names1[[1]][[1]]))
#[1] "subject"

#Using  tibble v3.0.3 library by Kirill M?ller
#add_rows(test.names, c(activity_labels))







