source("code.R")
library("tidyverse")
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

nodeTestData <- Node$new("Media")
nodeData1 <- Node$new("Kompas Polityczny")
nodeRealData <- Node$new("Kompas Polityczny")

testdata = read_csv("testdata.csv")
a1 = binary_tree(testdata[, 1:7], testdata[8:10], nodeTestData, "Start")
print(nodeTestData)

data1 = read_csv("data1.csv")
a2 = binary_tree(data1[, 1:15], data1[16:19], nodeRealData, "Start")
print(nodeRealData)


realData <- read.csv("realData.csv")
realData <- realData[,-1]
a3 <- binary_tree(realData[,1:15], realData[,16:19], node, "Start")

printableResult <- as.data.frame(node)
lol <- FrameTree
print(a3)

SetEdgeStyle(nodeTestData, arrowhead = "vee", penwidth = 4)
SetNodeStyle(nodeTestData, style = "filled,rounded", shape = "box", fillcolor = "#FFAEAA", fontname = "helvetica", fontcolor = "black", fontsize = 16)

plot(nodeTestData)
getRpartModel(nodeTestData)

sink("result.txt")
print(printableResult)

####################CLASSIFICATION TREE########################3
dataForTree <- realData[,-c(16:19)]
dependentVariables <- realData[,c(16:19)]

getFactorVariablesVector <- function(x){
  resultVector <- rep(1, times = nrow(x))
  for(i in 1:nrow(x)){
    for(j in 1:ncol(x)){
      currentDependentVariable <- x[i,j]
      if(j == 1 & currentDependentVariable == 1){
        resultVector[i] = colnames(x)[j]
      }
      else if(j == 2 & currentDependentVariable == 1){
        resultVector[i] = colnames(x)[j]
      }
      else if(j == 3 & currentDependentVariable == 1){
        resultVector[i] = colnames(x)[j]
      }
      else if(j == 4 & currentDependentVariable == 1){
        resultVector[i] = colnames(x)[j]
      }
    }
  }
  return (resultVector)
}

dependentVariableVector <- getFactorVariablesVector(dependentVariables)
ageVector <- getFactorVariablesVector(dataForTree[,c(1:3)])
educationVector <- getFactorVariablesVector(dataForTree[,c(4:6)])
dwellingPlaceVector <- getFactorVariablesVector(dataForTree[,c(7:9)])
labourVector <- getFactorVariablesVector(dataForTree[,c(10:13)])
gendereVector <- getFactorVariablesVector(dataForTree[,c(14:15)])


dataForTree <- data.frame(cbind(ageVector, educationVector, dwellingPlaceVector, labourVector, gendereVector ,dependentVariableVector))
colnames(dataForTree) <- c("age", "education", "dwelling place", "labour", "gender", "political preference")
dataForTree$age <- as.factor(dataForTree$age)
dataForTree$education <- as.factor(dataForTree$education)
dataForTree$`dwelling place` <- as.factor(dataForTree$`dwelling place`)
dataForTree$labour <- as.factor(dataForTree$labour)
dataForTree$gender <- as.factor(dataForTree$gender)

tree <- rpart(`political preference` ~ ., data = dataForTree, method = "class")

fancyRpartPlot(tree)

prunedTree <- prune(tree, cp = 0.0001)

fancyRpartPlot(prunedTree)
