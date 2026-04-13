library(tidyverse)
library(ggplot2)
library(rvest)

airportsRaw <- read_html(
  x = "https://en.wikipedia.org/wiki/List_of_busiest_airports_by_passenger_traffic"
) |>  html_elements(css = "table") |>
  html_table()

airportsSemiClean <- bind_rows(
  airportsRaw[[2]] |> mutate(year = 2025),
  airportsRaw[[3]] |> mutate(year = 2024),
  airportsRaw[[4]] |> mutate(year = 2023),
  airportsRaw[[5]] |> mutate(year = 2022),
  airportsRaw[[6]] |> mutate(year = 2021),
  airportsRaw[[7]] |> mutate(year = 2020)
) |> filter(str_detect(Airport, "Atlanta|Frankfurt|Beijing Daxing|Denver|Los Angeles|Dubai")) 

airportsClean <- airportsSemiClean |> rename(
  TotalPassengers = Totalpassengers,
  RankChange = Rankchange,
  PercentChange = `%change`,
  Year = year
) |> mutate(
  TotalPassengers = readr::parse_number(TotalPassengers)
) |> arrange(desc(TotalPassengers))


psuPallete <- c("#1E407C", "#BC204B", "#3EA39E", "#E98300", "#999999", "#AC8DCE", "#F2665E", "#99CC00")

ggplot(
  data = airportsClean,
  mapping = aes(
    x = Year,
    y = TotalPassengers,
    color = Airport,
    shape = Location
  )
) + 
  geom_point(size = 2) + 
  scale_color_manual(
    values = psuPallete
  ) + labs(
    x = "Year",
    y = "Total Passengers at Given Airport",
    color = "Airport",
    shape = "Location",
    title = "Busiest Airports by Passenger Traffic from year 2025-2020"
  ) + theme_minimal()
