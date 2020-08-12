baddata<- read.csv("activity.csv")
baddata$date<-as.Date(baddata$date)


data<-baddata[!is.na(baddata),]
hist1_data<-summarise(group_by(data,date),total=sum(steps))
hist(hist1_data$total,main = "histogram of total no. of steps per day",xlab="total no. of steps")
summary(hist1_data)
