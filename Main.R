source("TreeCode.R")
library("tidyverse")
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

nodeRealData <- Node$new("Kompas Polityczny")

realData <- read.csv("realData.csv")
realData <- realData[,-1]
listResult <- binary_tree(realData[,1:15], realData[,16:19], nodeRealData, "Start")

printableResult <- as.data.frame(nodeRealData)
print(listResult)

SetEdgeStyle(nodeTestData, arrowhead = "vee", penwidth = 4)
SetNodeStyle(nodeTestData, style = "filled,rounded", shape = "box", fillcolor = "#FFAEAA", fontname = "helvetica", fontcolor = "black", fontsize = 16)

plot(nodeRealData)
getRpartModel(nodeRealData)

sink("result.txt")
print(printableResult)


