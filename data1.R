library(tidyverse)
library("dummies")

list(
  Age = c("Under 28", "Between 28 and 45", "Beyond 45"),
  Education = c("Elementary", "High", "Graduate"),
  "Dwelling place" = c("Village", "Town", "City"),
  Labour = c("Unemployed", "Small company", "Huge company", "Self-employment"),
  Gender = c("Female", "Male")
  ) %>% expand.grid() %>% dummy.data.frame(sep = ": ") -> data

Parties = c("Autoritarian-right", "Autoritarian-left", "Libertarian-right", "Libertarian-left")
data[, Parties[1]] <- 1; data[, Parties[-1]] <- 0
write_csv(data, "data1.csv")

