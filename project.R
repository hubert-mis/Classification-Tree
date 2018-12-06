source("code.R")
library("tidyverse")

testdata = read_csv("testdata.csv")
a1 = binary_tree(testdata[, 1:7], testdata[8:10])

data1 = read_csv("data1.csv")
a2 = binary_tree(data1[, 1:15], data1[16:19])
