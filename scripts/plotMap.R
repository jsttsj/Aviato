library(plotly)

# This function plots a given data frame onto the map of the US.
plotMap <- function(to.plot) {
  # Specifications of the appearance of the map.
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("gray85"),
    subunitwidth = 1,
    countrywidth = 1,
    subunitcolor = toRGB("white"),
    countrycolor = toRGB("white")
  )
  
  # Plot the bubble map on Plotly
  p <- plot_geo(to.plot, locationmode = 'USA-states', sizes = c(1, 150), color=~ranking) %>%
    # Specifications of the bubble markers.
    add_markers(
      x = ~lon, y = ~lat, hoverinfo = "text", size = ~inv.rank,
      text = ~paste(to.plot$new.name, "<br />", to.plot$related.topic, "<br />", "#", to.plot$ranking)
    ) %>%
    layout(title = paste0("Trending levels of topics related to ", input$search), geo = g) %>%
    return()
}