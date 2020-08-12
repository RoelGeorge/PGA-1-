baddata<- read.csv("activity.csv")

baddata$date<-as.Date(baddata$date)


data<-baddata[!is.na(baddata),]


hist1_data<-summarise(group_by(data,date),total=sum(steps))
hist(hist1_data$total,main = "histogram of total no. of steps per day",
     xlab="total no. of steps")
summary(hist1_data)


steps_by_interval <- aggregate(steps ~ interval, data, mean)
plot(steps_by_interval$interval,steps_by_interval$steps, type = "l",
     xlab = "interval",ylab = "avg steps")

steps_by_interval[which.max(steps_by_interval$steps),]

data['type_of_day'] <- weekdays(data$date)

data$type_of_day[data$type_of_day  %in% c('Saturday','Sunday') ] <- "weekend"

data$type_of_day[data$type_of_day != "weekend"] <- "weekday"

data$type_of_day <- as.factor(data$type_of_day)


data_steps_by_interval <- aggregate(steps ~ interval + type_of_day,
                                    data, mean)


qplot(interval, 
      steps, 
      data = data_steps_by_interval, 
      type = 'l', 
      geom=c("line"),
      xlab = "Interval", 
      ylab = "Number of steps", 
      main = "") +
    facet_wrap(~ type_of_day, ncol = 1)




