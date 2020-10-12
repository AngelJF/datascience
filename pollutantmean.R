pollutantmean<- function (directory, pollutant, id= 1:332)
{
  ##'directory' is a character vector of length 1 indicating
  ##'the location of the CSV files
  #Read the files in the directory in a list format
    Filesjob<- list.files(directory, full.names = TRUE)
  #Create a data frame space
    LISTDATA<- data.frame()
  #Read the specified files by id
        for (i in id){
        LISTDATA <- rbind(LISTDATA, na.exclude(read.csv(Filesjob[i])))
        }
  #Calculate the mean
    mean(LISTDATA[,pollutant], na.rm = TRUE)
  
  #First code attempt, only usable when is a single file selected
  #if (id>332)
  #{
  #  print("Id out of range")
  #  break
  #}
  #if (id<10){
  #  id1 <- paste("00",id, sep="")
  #  whichfileu <- paste(directory,"/", id1,".csv", sep="")
  #} else if ((id>=10)&(id<100)){
  #  id2 <-paste("0",id, sep="")
  #  whichfileu <- paste(directory,"/", id2,".csv", sep="")
  #} else 
  #  whichfileu <- paste(directory,"/", id,".csv", sep="")
  ##'id' is an integer vector indication the monitos ID numbers
  ##'to be used
  
  #usedfile <- read.csv(whichfileu)
  #print(usedfile) to check the used file 
 
  #mean(usedfile[,pollutant], na.rm = TRUE)
  ##'pollutant' is character vector of length 1 indicating
  ##'the name of the pullutant for which we will calculate the
  ##'mean: either "sulfate" or "nitrate".
  
  ##Return the mean of the pollutant across all monitors listh
  ##in the 'id' vector(ignoring NA values)
  ##NOTE: Do not round the result!
}