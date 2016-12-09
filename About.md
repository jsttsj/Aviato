Richard Kim, Jenny Liang, Sean Mahoney, Jonathan san Thiem

INFO 201 

	Project Description

We created a web application that shows the geographical popularity of trending hashtags on Twitter in the United States. We worked with the Twitter REST API, which returns information such as Twitter users, their tweets, and the location of posted tweets. The documentation for this API may be found [here] (https://dev.twitter.com/rest/public). We will make the city data points readable by the Twitter API and plottable by Plotly by modifying a [github resource](https://raw.githubusercontent.com/plotly/datasets/master/2014_us_cities.csv) to convert them into latitude and longitude points.

The target audience of this project will be for people who frequently use Twitter in the United States. This is because with the analysis on these datasets, we hope to make Twitter users more aware of the interactions they have within the Twitter community by learning:


> **How popular is a given event or concept is among different populations or geographic locations in the United States?**

>**How does popularity of social media, specifically Twitter is, vary in different locations in the United States?**

>**How does the mutual relationship of how social media drives concept popularity and how concept popularity drives social media usage work?**

>**How is community constructed in social media, more specifically based off of shared concepts and interests?**

>**How do users interact with shared concepts and interests?**
  
  

	Technical Description
The format of this application is a R Shiny website. It reads in the data using a RESTful API for Twitter, and static .csv files for state and national locations. We reshaped our data by joining the two data sets by city or by longitude and latitude, and grouping data points by region for further insight. There are no new libraries that we used. The first two questions listed in the previous question will be answered with statistical analysis. The most challenging part of this assignment was becoming familiar with using the Twitter API and the github resource mentioned above to retrieve the information that is necessary for the project.

    Results
After using our application, some notable trends that we noticed is that similar hashtags were generally used all around the country. That is, if you looked up a topic, the same hashtag would be in most of the cities around the US, generally in the same exact rank. Also, popular trends were based on current events; in particular, sports and entertainment played a big role in causing trends.
