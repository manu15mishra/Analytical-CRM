#Set the working directory
setwd("F:\\Material\\Sem 2\\Analytical CRM\\Project\\dunnhumby_Breakfast-at-the-Frat")
#Provide the store details dataset
input1<-read.csv("store_data_1.csv")
#Provide transaction details dataset
input2<-read.csv("transaction_final.csv")
#install "sqldf" package
install.packages("sqldf")
#import thr "sqldf" library
library(sqldf)
#import "dplyr" library
library(dplyr)
#applying SQL command to get Mainstream store data
store<-sqldf("SELECT STORE_ID FROM input1 WHERE SEG_VALUE_NAME='MAINSTREAM'")
#applying SQL command to get Upscale store data
store1<-sqldf("SELECT STORE_ID FROM input1 WHERE SEG_VALUE_NAME='UPSCALE'")
#applying SQL command to get Value store data
store2<-sqldf("SELECT STORE_ID FROM input1 WHERE SEG_VALUE_NAME='VALUE'")
#binding the values by row
y<-rbind(store,store1)
#binding the values by row
y<-rbind(y,store2)
#changing the datatype to numeric
store<-as.numeric(unlist(store))
##changing the datatype to numeric
store1<-as.numeric(unlist(store1))
#changing the datatype to numeric
store2<-as.numeric(unlist(store2))
#changing the datatype to numeric
y<-as.numeric(unlist(y))
#changing column names
colnames(input2)[2]<-"STORE_ID"
#filtering the data 
x<-filter(input2,STORE_ID %in% y)
#writing the contents to csv file
write.csv(x,file="test1.csv",row.names=F)
#applying filter condition to get Mainstream store data
z<-filter(x,STORE_ID %in% store)
#applying filter condition to get Mainstream store data
z1<-filter(x,STORE_ID %in% store1)
#applying filter condition to get Mainstream store data
z2<-filter(x,STORE_ID %in% store2)
#writing the respective values to csv files
write.csv(z,file="mainstream.csv",row.names=F)
write.csv(z1,file="upscale.csv",row.names=F)
write.csv(z2,file="value.csv",row.names=F)
#import "corrplot" package for correlation matrix
install.packages("corrplot")
#loading the library
library(corrplot)
#getting column names
colnames(x)
#removing the redundant columns
x[1:6] <- NULL
x[2:3] <- NULL
#renaming the columns
colnames(x)[1]<-"Sales"
colnames(x)[2]<-"Feature"
colnames(x)[3]<-"Display"
colnames(x)[4]<-"TPR_only"
#creating the correlation matrix
c <- cor(x)
head(round(c,2))
#plotting the correlation matrix
corrplot(c,method="number",type="upper")
#repeating the above steps to create correlation matrix for Mainstream stores
a<-read.csv("F:\\Material\\Sem 2\\Analytical CRM\\Project\\dunnhumby_Breakfast-at-the-Frat\\Final\\datasets\\Mainstream_Store.csv")
head(a)
a1<-cor(a)
head(round(a1,2))
corrplot(a1,method="number",type="upper")
#repeating the above steps to create correlation matrix for Upscale stores
b<-read.csv("F:\\Material\\Sem 2\\Analytical CRM\\Project\\dunnhumby_Breakfast-at-the-Frat\\Final\\datasets\\Upscale_store.csv")
head(b)
b1<-cor(b)
head(round(b1,2))
corrplot(b1,method="number",type="upper")
#repeating the above steps to create correlation matrix for Value stores
c<-read.csv("F:\\Material\\Sem 2\\Analytical CRM\\Project\\dunnhumby_Breakfast-at-the-Frat\\Final\\datasets\\Values_store.csv")
head(c)
c1<-cor(c)
head(round(c1,2))
corrplot(c1,method="number",type="upper")
