#Week 4 Getting data
#Question 1
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
#              destfile = "AmCS.csv")
data<- read.csv("AmCS.csv")
#Get specified data subset(data, data$ACR == 3 & data$AGS == 6)
Agricultural<- strsplit(names(data), "wgtp")
Agricultural[[123]]

###############################################################
#Question 2
library(data.table)
library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile= "GDProduct.csv", method = "curl")
data1 <- fread("GDProduct.csv", skip = 5, nrows = 190, select = c(1, 2, 4, 5), 
               col.names = c("CountryCode", "Ranking", "Economy", "Total"))
data1<- mutate(data1, TotalF= gsub(',', "", data1$Total, fixed = TRUE))
data1<- mutate(data1, TotalF= as.numeric(TotalF))
mean(data1$TotalF)

###############################################################
#Question 2
countrynames <- fread("GDProduct.csv", skip = 5, nrows = 190, select = c(4), 
                      col.names = c("countrynames"))
grep("^United", countrynames$countrynames)

###############################################################
#Question 3
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv" , 
#             destfile="FEDSTATS.csv", method = "curl")
data2<- read.csv("FEDSTATS.csv")
datamerg<- merge(data1, data2, by = "CountryCode")
grep("end: June", datamerg$Special.Notes)
howmany<- length(grep("end: June", datamerg$Special.Notes))
howmany

###############################################################
#Question 4
#install.package("quantmod")
library(lubridate)
library(quantmod)
library(dplyr)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
# Dates are in the ymd

#Just in case unique values are necesary %>%       unique
#If unique is not used there will be duplicated values
#This changes all values to 2012
year2012<-unique(isoyear(sampleTimes, 2012))
datamondays <- `year<-`(sampleTimes, 2012) %>%
                       `wday<-`(week_start = 7, 2) %>%
                      unique

length(datamondays)
#Week days levels Sun < Mon < Tue < Wed < Thu < Fri < Sat
#Week start ISO = Monday
# which<- `wday<-`(sampleTimes, week_start = 7, 2)




# solution
timeDT <- data.table::data.table(timeCol = sampleTimes)

# How many values were collected in 2012? 
timeDT[(timeCol >= "2012-01-01") & (timeCol) < "2013-01-01", .N ]
# Answer: 
# 250

# How many values were collected on Mondays in 2012?
timeDT[((timeCol >= "2012-01-01") & (timeCol < "2013-01-01")) & (weekdays(timeCol) == "Monday"), .N ]
# Answer:
# 47


