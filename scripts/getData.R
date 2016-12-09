library(dplyr)

# Removes the data necessary 
getData <- function() {
  # Obtain a vector of all city names so it is easier to traverse through the matrix.
  all.cities <- rownames(city.data)
  
  # Create vectors for topic ranking and the corresponding related topics based on the
  # search string so that they can be added to the plotted data frame later.
  ranking <- vector(mode="integer", length = length(all.cities))
  related.topic <- vector(mode="character", length = length(all.cities))
  
  # Consolidate the the information into that will be displayed to the user into 
  # a single dataframe
  for(city in 1:size) { 
    # Obtain information on the popular topics in a given city.
    current.city <- all.cities[city]
    most.popular <- city.data[[current.city, 1]]
    # Conditions to control the while loop
    has.match <- FALSE
    index <- 1
    # Given the list of popular topics, traverse the list until a match is found or the list ends.
    while(has.match == FALSE && index < 21) {
      # Initialize dummy values to be placed in the data frame.
      put.related.topic <- ""
      put.ranking <- 0
      popular.topic <- most.popular[[index]]$name
      # Check if the search string is related to a popular topic in the city.
      # If there is a popular topic, update the dummy values initialized earlier.
      if(grepl(searchString(), tolower(gsub(" ", "", popular.topic))) == TRUE) {
        put.related.topic <- popular.topic
        put.ranking <- index
        has.match <- TRUE
      }
      # Record the values into the data frame.
      ranking[city] <- put.ranking
      related.topic[city] <- put.related.topic
      # Continue traversing the matrix.
      index <- index + 1
    }
  }
  
  # Return a new data frame containing city name with geographical location and the
  # name and popularity of the matched topic. Only return cities that have trending topics
  # related to the search string.
  return(cities %>%
           select(new.name, lat, lon) %>%
           mutate(ranking, related.topic) %>%
           filter(ranking != 0)) 
}