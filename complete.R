complete <- function(directory,id = 1:332){
     fullfiles<- list.files(directory, full.names = TRUE)
     cases1<- data.frame()
     casesid <- data.frame()
     cases<- data.frame()
        for (i in id){
        cases1 <- rbind(cases1, nrow(na.exclude(read.csv(fullfiles[i]))))
        casesid <- rbind(casesid, i)
        }  
     cases <- cbind(casesid, cases1)
     colnames(cases)<- c("id", "nobs")
     cases
}

  ##'directory' is a character vector of length 1 indicating
  ##'the location of the CSV files
  ##'
  ##'id' is an integer vector indicating the monitor ID numbers
  ##'to be used
  ##'
  ##'Return a data frame of the form:
  ##'id nobs
  ##'1 117
  ##'2 1041
  ##'... 
  ##'where 'id' is the monitor ID number and 'nobs' is the 
  ##'number of complete cases