source("code.R")
library("tidyverse")

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
print(node)

SetEdgeStyle(nodeTestData, arrowhead = "vee", penwidth = 4)
SetNodeStyle(nodeTestData, style = "filled,rounded", shape = "box", fillcolor = "#FFAEAA", fontname = "helvetica", fontcolor = "black", fontsize = 16)

plot(nodeTestData)
