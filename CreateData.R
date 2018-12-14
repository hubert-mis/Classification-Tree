library(tidyverse)
library(fastDummies)

list(
  age = c("under 28", "between 28 and 45", "beyond 45"),
  education = c("elementary", "high", "graduate"),
  "dwelling place" = c("village", "town", "city"),
  labour = c("unemployed", "small company", "huge company", "self-employment"),
  gender = c("female", "male")) %>%
  
  expand.grid() %>% dummy_cols() %>% select(-(1:5)) -> data
#parties = c("autoritarian-right", "autoritarian-left", "libertarian-right", "libertarian-left")
#data[, parties[1]] <- 1; data[, parties[-1]] <- 0
#write_csv(data, "data.csv")

#initalizing wages vectors
age_wages <- list("under 28" = c(-1, -2), "between 28 and 45" = c(1,0), "beyond 45" = c(2,2))
education_wages <- list(elementary = c(1,3), high = c(-1, -1), graduate = c(0,-2))
dwelling_place_wages <- list(village = c(2,3), town = c(-1, 0), city = c(-1, -3))
labour_wages <- list(unemployed = c(-3, 2), "small company" = c(-2, 1), "huge company" = c(1, -2), "self-employment" = c(3,0))
gender_wages <- list(female = c(0, -2), male = c(1,1))

wages_list <- c(age_wages, education_wages, dwelling_place_wages, labour_wages, gender_wages)

parties = c("autoritarian-right", "autoritarian-left", "libertarian-right", "libertarian-left")

#compute political preference matrix
computePreferencesMatrix <- function(entryData){
  preferencesMatrix <- matrix(nrow = nrow(entryData), ncol = length(parties))
  for(i in 1:nrow(entryData)){
    tempResult <- c(0,0)
    for(j in 1:ncol(entryData)){
      tempResult <- tempResult + entryData[i,j] * wages_list[[j]]
      if(tempResult[1] > 0 && tempResult[2] > 0){
        preferencesMatrix[i, ] <- c(1,0,0,0)
      }
      else if (tempResult[1] < 0 && tempResult[2] < 0){
        preferencesMatrix[i, ] <- c(0,0,0,1)
      }
      else if (tempResult[1] < 0 && tempResult[2] >= 0){
        preferencesMatrix[i, ] <- c(0,1,0,0)
      }
      else if (tempResult[1] >= 0 && tempResult[2] < 0){
        preferencesMatrix[i, ] <- c(0,0,1,0)
      }
      else if (tempResult[1] == 0 && tempResult[2] == 0){
        preferencesMatrix[i, ] <- c(NA, NA, NA, NA)
      }
    }
  }
  return (preferencesMatrix)
}

#create resulting matrix
resultData <- cbind(data, computePreferencesMatrix(data))
colnames(resultData)[(ncol(resultData) - length(parties)+1):ncol(resultData)] <- parties
resultData <- resultData[complete.cases(resultData),]

write.csv(resultData, "realData.csv")

