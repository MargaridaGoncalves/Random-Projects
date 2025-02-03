library(shiny)
library(leaflet)
library(shinyjs)
library(readxl)
library(dplyr)

# Clear variables
rm(list=ls())
#Get path
path<-getwd(); path
# Set path
setwd(path)

endemic <- read_excel("is_endemic.xlsx")
worldcities <- read_excel("worldcities.xlsx")
capitals <- read_excel("capitalCities.xlsx")

cities <- worldcities %>%
  group_by(country) %>%
  slice(1)



data <-  data.frame(
  lng = capitals$Longitude,
  lat = capitals$Latitude,
  name = capitals$Country
) 

ui <- fluidPage(
  titlePanel("Carrega em locais onde há transmissão de malaria:"),
  leafletOutput("map", height = "70vh"),
  useShinyjs(),
  p("by AG and NSO from PEvoGEn/ICVS"),
  div(id = "feedback", style = "font-weight: bold; color: green;"),
  div(id = "feedback2", style = "font-weight: bold; color: blue;"),
  div(id = "feedback4", style = "font-weight: bold; color: black;"),
  div(id = "feedback3", style = " color: black;")
)

server <- function(input, output) {
  # Render Leaflet map
  output$map <- renderLeaflet({
    leaflet(data) %>%
      addTiles() %>%
      addCircleMarkers(~lng, ~lat, popup = ~as.character(name), radius= 4)%>%
      setView(lng = 0, lat = 0, zoom = 3)
  }) # input$map_click and input$map_marker_click
  
  
  # Create reactive values for selected regions and correct guesses
  selected_regions <- reactiveVal(character(0))  # Stores unique regions already selected
  correct_guesses <- reactiveVal(0)
  
  # Observe clicks on the map
  observeEvent(input$map_marker_click, {
    click <- input$map_marker_click
    # Check if the clicked coordinates match any row in the dataset
    matched_row <- endemic[round(endemic$lng) == round(click$lng) & round(endemic$lat) == round(click$lat),]
    
    if (nrow(matched_row) > 0) {  # If a match is found
      clicked_region <- matched_row$region[1]
      
      # Check if the region has already been selected
      if (!(clicked_region %in% selected_regions())) {
        # Add the region to the selected list and increment the counter
        selected_regions(c(selected_regions(), clicked_region))
        correct_guesses(correct_guesses() + 1)
        shinyjs::html("feedback", "Correto!")
      } else {
        shinyjs::html("feedback", "Já selecionaste essa região.")
      }
    } else {
      shinyjs::html("feedback", "Incorreto.")
    }
    
    shinyjs::show("feedback")
    shinyjs::html("feedback2", paste("Clicks corretos:", correct_guesses()))
    shinyjs::html("feedback4", paste(""))
    shinyjs::html("feedback3", selected_regions())
    shinyjs::show("feedback2")
    shinyjs::show("feedback4")
    shinyjs::show("feedback3")
    
    # End of the game
    if (correct_guesses() == 30) {
      showModal(
        modalDialog(
          title = "Parabéns!",
          "Acertaste 30 vezes! 🎉")
        )
      
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
