corr <- function(directory, threshold = 0){
      #creation of filelistdirectory
      Fileslist<- list.files(directory, full.names = TRUE)
      #creation of empy dataframe for cases directory
      cases1<- data.frame()
      casesid <- data.frame()
      #loop for all the content of the directory
      id = 1:length(Fileslist)
      for (i in id){
            l<- id[i]
            #Number of cases (cases1)
            cases1 <- rbind(cases1, nrow(na.exclude(read.csv(Fileslist[i]))))
            casesid <- rbind(casesid, i)
      } 
      #Cases directory
      cases <- cbind(casesid, cases1)
      colnames(cases)<- c("id", "nobs")
      nobs<- as.list(cases["nobs"])
    
      
        #Loop for evaluation and assignment of files cases>threshold
      forcor<- data.frame()
      #Initial position
      pos<- 0
      for (j in nobs){ 
          h<- j
          #print(h): h = nobs value
          #evaluation of initial position in the list
          if (pos==0){
              pos = pos + 1  
          } else if (pos>=1){ 
              pos = pos+1
          }
      #Threshold evaluation nobs value vs threshold
          if (h > threshold){
              forcor<- rbind(forcor, na.exclude(read.csv(Fileslist[pos])))
          }
            
      }  
      #Correlation evaluation
      sulfate<- forcor["sulfate"]
      nitrate<- forcor["nitrate"]
      corre<- cor(sulfate, nitrate) 
}

  

  
  
  
    ##'directory' is a character vector of length 1 indicating
    ##'the location of the CSV files
    ##'
    ##'treshold' is a numeric vector of length 1 indicating the
    ##'number of completely observed observations (on all 
    ##'variables) required to compute the correlation between 
    ##'nitrate and sulfate; the default is 0
    ##'
    ##'
    ##'Return a numeric vector of correlation
    ##'NOTE:Do not round the result!