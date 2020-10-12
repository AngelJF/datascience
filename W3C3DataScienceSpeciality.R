#Week3 Getting data
#Question 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
              destfile = "AmCS.csv")
data<- read.csv("AmCS.csv")
#Get specified data subset(data, data$ACR == 3 & data$AGS == 6)
agricultureLogical<- which(data$ACR == 3 & data$AGS == 6)

###############################################################
#Question 2
#install.packages("jpeg")
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", 
              destfile= "GdataJeff.jpg", mode = 'wb')
image <- readJPEG("GdataJeff.jpg", native=TRUE)
quantile(image, probs = c(0.30, 0.80))
###############################################################
#Question 3 
library(data.table)
library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile= "GDProduct.csv", method = "curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv" , 
              destfile="FEDSTATS.csv", method = "curl")

data1 <- fread("GDProduct.csv", skip = 5, nrows = 190, select = c(1, 2, 4, 5), 
               col.names = c("CountryCode", "Ranking", "Economy", "Total"))
data2<- read.csv("FEDSTATS.csv")
datamerg<- merge(data1, data2, by = "CountryCode")
nrow(datamerg)
order<- arrange(datamerg, desc(Ranking))
arrange(datamerg, desc(Ranking))[13, "Economy"]



###############################################################
#Question 3

tapply(datamerg$Ranking, datamerg$Income.Group, mean)



###############################################################
#Question 4
datamerg$RankGroups <- cut(datamerg$Ranking, breaks = 5)
table(datamerg$RankGroups, datamerg$Income.Group)



