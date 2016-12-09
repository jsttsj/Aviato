library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
library(jsonlite)
library(twitteR)

# Call the API
available.trends<-twitteR::availableTrendLocations()
df <- read.csv("../data/us_city_locations.csv",stringsAsFactors = FALSE)
df.nopop<-select(df,-pop)
# Caluclate values for longitude and latitude for each city.
df.norep<-group_by(df,name)%>%
  summarise(lat=mean(lat),lon=mean(lon))
# Manually reset name for some cities to match API.
df.norep[26,"name"]="Nashville "
df.norep[13,"name"]="Indianapolis "
# Manually set the longitude and lattitude for some cities. 
df.norep.plus<-rbind(df.norep,c("Birmingham ",33.5207,-86.8025),c("Dallas-Ft. Worth ",32.8998,-97.0403),c("Honolulu ",21.3069,-157.8583),c("Norfolk ",36.8508,-76.2859))
# Obtain all the cities in the United states.
us.trends<-filter(available.trends, country=="United States")
us.trends$new.name<-paste0(us.trends[,"name"]," ")


# Use this Dataframe. 
# Join the two data frames to match each city with a longitue and lattitude
city.local<-left_join(us.trends,df.norep.plus,by=c("new.name"="name"))

