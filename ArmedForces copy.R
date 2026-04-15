# US Armed Forces Activity Duty Data
## Pull data From  US Armed Forces Activity Duty Data, combine with Pay grade and Rank, & clean the table 
## Be sure to start each line with ##

# Step 1: Load Packages ----
library(googlesheets4)
library(tidyverse)
library(rvest)

# Step 2: Load Data ----
gs4_deauth()
armedForcesRaw<- read_sheet(
  ss = "https://docs.google.com/spreadsheets/d/19xQnI1cBh6Jkw7eP8YQuuicMlVDF7Gr-nXCb5qbwb_E/edit?gid=597536282#gid=597536282",
  skip = 2, 
  col_names = FALSE
) 
#Finally figured out a way to read the columns right
names(armedForcesRaw) <- armedForcesRaw[1,]

names(armedForcesRaw) <- c(
  "PayGrade",
  "Army_Male", "Army_Female", "Army_Total",
  "Navy_Male", "Navy_Female", "Navy_Total",
  "MarineCorps_Male", "MarineCorps_Female", "MarineCorps_Total",
  "AirForce_Male", "AirForce_Female", "AirForce_Total",
  "SpaceForce_Male", "SpaceForce_Female", "SpaceForce_Total",
  "Total_Male", "Total_Female", "Total_Total"
)

armedForcesCleaned <- armedForcesRaw |>
  filter(PayGrade %in% c("W1", "W2", "W3", "W4", "W5"))

armedForcesCleaned <- armedForcesCleaned |>
  pivot_longer(
    cols = -PayGrade,
    names_to = c("Branch", "Gender"),
    names_sep = "_",
    values_to = "Count"
  ) |>
  filter(Gender != "Total") |>
  filter(Branch != "Total")

maleFrequencyTable <- armedForcesCleaned |>
  filter(Gender == "Male") |>
  select(PayGrade, Branch, Count)

femaleFrequencyTable <- armedForcesCleaned |>
  filter(Gender == "Female") |>
  select(PayGrade, Branch, Count)
# col_names <- c("PayGrade",
#                "Army_Male", "Army_Female", "Army_Total",
#                "Navy_Male", "Navy_Female", "Navy_Total",
#                "MarineCorps_Male", "MarineCorps_Female", "MarineCorps_Total",
#                "AirForce_Male", "AirForce_Female", "AirForce_Total",
#                "SpaceForce_Male", "SpaceForce_Female", "SpaceForce_Total",
#                "Total_Male", "Total_Female", "Total_Total")
# 
# names(armedForcesRaw) <- col_names
# armedForcesRaw <- armedForcesRaw |> slice(-1) |> slice(-nrow(armedForcesRaw))
# 
# 
# armedForcesCleaned <- armedForcesRaw |>
#   pivot_longer(
#     cols = -PayGrade,
#     names_to = c("Branch", ".value"),
#     names_sep = "_"
#   ) |>
#   select(-Total) |>           # drop totals
#   pivot_longer(
#     cols = c(Male, Female),
#     names_to = "Sex",
#     values_to = "Count"
#   ) |>
#   filter(!str_detect(PayGrade, "Total"))  # remove summary rows



  ##pivot_longer(
 ## data = armedForcesRaw, cols = c("Army", "Navy", "Marine Corps", "Air Force", 
    ##                              "Space Force"), names_to = "Branch"
