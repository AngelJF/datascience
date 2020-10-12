corr <- function(directory, threshold = 0){
      #creation of filelistdirectory
      Fileslist<- list.files(directory, full.names = TRUE)
      #creation of empty dataframe for cases directory
      cases1<- data.frame()
      casesid <- data.frame()
      #empty dataframe for threshold data result
      forcor<-data.frame()
      #empty dataframe for correlation results
      #corre<-data.frame()
      #empy list for correlation results
      corre2<- rep(0, length(Fileslist))
      #loop for all the content of the directory
      id = 1:length(Fileslist)
      for (i in id){
            
            #Number of cases (cases1)
            nobs <- rbind(cases1, nrow(na.exclude(read.csv(Fileslist[i]))))
      #Threshold evaluation nobs value vs threshold
            if (nobs > threshold){
              forcor<-  na.exclude(read.csv(Fileslist[i]))
              compari<- forcor[,c(2,3)]
              
              
              #corre<- rbind(corre, cor(compari[,1], compari[,2]))
              corre2[i]<- cor(compari[,1], compari[,2])
              remove <- 0
              #Remove 0
              corre2 <- corre2 [! corre2 %in% remove]
              #Remove NA values
              corre2<- na.exclude(corre2)
            } 
      
      } 
      #Final result
      #corre
      corre2
       
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