library(utils)
library(forecast)
library(fUnitRoots)
library(urca)
library(stats)
library(tseries)
table<-read.table("C:/Users/Charles/Documents/ENSAE/Séminaire de modélisation statistique/alldata_sujet1.csv", sep=",",header=TRUE)
table$time<-as.POSIXct(strptime(paste(table$date,table$heure,sep=" "), "%Y-%m-%d %H"))
table$day<-weekdays(table$time)
table$month<-months(table$time)
table$time<-NULL
table$date<-NULL
table_train<-table[35065:87649,]
table_test<-table[87659:96409,]

conso<-as.ts(table$LOAD, start=c(2005,01,1,1), end=c(2011,12,31, 0))
plot(conso)
modele<-glm(LOAD~., data=table_train)
summary(modele)
table_test2<-table_test
table_test2$LOAD<-NULL
table_test$LOAD_pred<-predict(modele, newdata=table_test,se.fit=TRUE)
table_test$LOAD_pred[5]
err<-table_test$LOAD_pred-table_test$LOAD
