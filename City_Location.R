library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
library(jsonlite)
library(twitteR)

available.trends<-twitteR::availableTrendLocations()
df <- read.csv("us_city_locations.csv",stringsAsFactors = FALSE)
df.nopop<-select(df,-pop)
df.norep<-group_by(df,name)%>%
  summarise(lat=mean(lat),lon=mean(lon))
df.norep[26,"name"]="Nashville "
df.norep[13,"name"]="Indianapolis "
df.norep.plus<-rbind(df.norep,c("Birmingham ",33.5207,-86.8025),c("Dallas-Ft. Worth ",32.8998,-97.0403),c("Honolulu ",21.3069,-157.8583),c("Norfolk ",36.8508,-76.2859))
us.trends<-filter(available.trends, country=="United States")
us.trends$new.name<-paste0(us.trends[,"name"]," ")


#Use this Dataframe.
city.local<-left_join(us.trends,df.norep.plus,by=c("new.name"="name"))

