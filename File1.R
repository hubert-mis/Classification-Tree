library(tidyverse)
library(fastDummies)

list(
  age = c("under 28", "between 28 and 45", "beyond 45"),
  education = c("elementary", "high", "graduate"),
  "dwelling place" = c("village", "town", "city"),
  labour = c("unemployed", "small company", "huge company", "self-employment"),
  gender = c("female", "male")) %>%
  
  expand.grid() %>% dummy_cols() %>% select(-(1:5)) -> data
parties = c("autoritarian-right", "autoritarian-left", "libertarian-right", "libertarian-left")
data[, parties[1]] <- 1; data[, parties[-1]] <- 0
write_csv(data, "data.csv")


