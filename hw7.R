library(readr)
library(zoo)
library(stringr)

clean_data <- read_csv("~/Downloads/dirty_data.csv")

clean_data$Area=na.locf(na.locf(dirty_data$Area,na.rm=FALSE),fromLast=TRUE)


clean_data$Street=str_replace_all(clean_data$Street, "[^[:alnum:]]", " ")

clean_data$`Street 2`=str_replace_all(clean_data$`Street 2`, "[^[:alnum:]]", " ")

clean_data$Street=str_replace_all(clean_data$Street, "[[:punct:]]", " ")

clean_data$`Street 2`=str_replace_all(clean_data$`Street 2`, "[[:punct:]]", " ")


x=clean_data[which(clean_data$Street==clean_data$`Street 2`),]
for(i in 1:dim(clean_data)[[1]]){
  if (clean_data$Street[i]==clean_data$`Street 2`[i]){
    clean_data$`Street 2`[i]=''
  }
}

clean_data$Street=str_to_title(clean_data$Street)
clean_data$Street=gsub("St.*","Str.",clean_data$Street)
clean_data$Street=gsub("Av.*","Ave.",clean_data$Street)
clean_data$Street=gsub("Ro.*","Rd.",clean_data$Street)
clean_data$Street=gsub("La.*","Ln.",clean_data$Street)
clean_data=subset(clean_data, select=c("Year","Area","Street","Street 2") )