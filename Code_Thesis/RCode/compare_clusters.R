library(dplyr)
library(productplots)
library(CGPfunctions)
library(tidyverse)

source("http://pcwww.liv.ac.uk/~william/R/crosstab.r")

dataID=read.table("data_ID.txt", fill = TRUE , header = TRUE )
data1=read.table("data_segment1.txt", fill = TRUE , header = TRUE )
data2=read.table("data_segment2.txt", fill = TRUE , header = TRUE )
data3=read.table("data_segment3.txt", fill = TRUE , header = TRUE )

groupA <- group_Combo1
W_statsA <- W_stats_Combo1
groupB <- group_Combo2
W_statsB <- W_stats_Combo2

dataFinalA=data.frame(groupA)
dataFinalB=data.frame(groupB)

infosinglesA <- cbind(dataFinalA, dataID)
infosinglesB <- cbind(dataFinalB, dataID)

#singlesA <- data.frame(matrix(0,length(groupA),1))
#singlesB <- data.frame(matrix(0,length(groupB),1))

dataTotalA <- cbind(dataID, dataFinalA, data1, data2)
dataTotalB <- cbind(dataID, dataFinalB, data1, data2, data3)

ClustSizeA <- W_statsA$cluster.size
ClustSilA <- W_statsA$clus.avg.silwidths
ClustSizeB <- W_statsB$cluster.size
ClustSilB <- W_statsB$clus.avg.silwidths

singletonsA <- which(ClustSizeA!=1)
singletonsB <- which(ClustSizeB!=1)

minisA <- which(ClustSizeA<=(0.01*dim(dataTotalA)[1]))
minisB <- which(ClustSizeB<=(0.01*dim(dataTotalB)[1]))

max1A <- match(max(ClustSizeA), ClustSizeA)
max2A <- match(max( ClustSizeA[ClustSizeA!=max(ClustSizeA)] ),ClustSizeA)
max1B <- match(max(ClustSizeB),ClustSizeB)
max2B <- match(max( ClustSizeB[ClustSizeB!=max(ClustSizeB)] ),ClustSizeB)

singlesA <- dataTotalA
bigsA <- dataTotalA
big1A <- dataTotalA
big2A <- dataTotalA
singlesA <- singlesA[!(singlesA$groupA %in% singletonsA),]
bigsA <- bigsA[!(bigsA$groupA %in% minisA),]
big1A <- big1A[(big1A$groupA %in% max1A),]
big2A <- big2A[(big2A$groupA %in% max2A),]

singlesB <- dataTotalB
bigsB <- dataTotalB
big1B <- dataTotalB
big2B <- dataTotalB
singlesB <- singlesB[!(singlesB$groupB %in% singletonsB),]
bigsB <- bigsB[!(bigsB$groupB %in% minisB),]
big1B <- big1B[(big1B$groupB %in% max1B),]
big2B <- big2B[(big2B$groupB %in% max2B),]

#sapply(bigsA, function(x) length(unique(x)))
#sapply(bigsB, function(x) length(unique(x)))

inter1A <- dataTotalA
ask_index <- 52
inter1A_85 <- inter1A[(inter1A$groupA %in% ask_index),]

inter1A <- dataTotalA
ask_index <- 72
inter1A_82 <- inter1A[(inter1A$groupA %in% ask_index),]

inter1A <- dataTotalA
ask_index <- 66
inter1A_72 <- inter1A[(inter1A$groupA %in% ask_index),]

inter1A <- dataTotalA
ask_index <- 2
inter1A_65 <- inter1A[(inter1A$groupA %in% ask_index),]


inter1B <- dataTotalB
ask_index <- 93
inter1B_37 <- inter1B[(inter1B$groupB %in% ask_index),]

inter1B <- dataTotalB
ask_index <- 91
inter1B_36 <- inter1B[(inter1B$groupB %in% ask_index),]

inter1B <- dataTotalB
ask_index <- 90
inter1B_33 <- inter1B[(inter1B$groupB %in% ask_index),]

inter1B <- dataTotalB
ask_index <- 85
inter1B_23 <- inter1B[(inter1B$groupB %in% ask_index),]

z <- (big2A$ID %in% big2B$ID)
print(length(z[z==TRUE]))
