library(stats)
library(PoweR)
library(matrixStats)
library(dgof)

set.seed(123)

data1=read.table("data_segment1.txt", fill = TRUE , header = TRUE )
data2=read.table("data_segment2.txt", fill = TRUE , header = TRUE )
data3=read.table("data_segment3.txt", fill = TRUE , header = TRUE )
data4=read.table("data_segment4.txt", fill = TRUE , header = TRUE )
data5=read.table("data_segment5.txt", fill = TRUE , header = TRUE )
data6=read.table("data_segment6.txt", fill = TRUE , header = TRUE )


range1 <- colRanges(data.matrix(data1))
range2 <- colRanges(data.matrix(data2))
range3 <- colRanges(data.matrix(data3))
range4 <- colRanges(data.matrix(data4))
range5 <- colRanges(data.matrix(data5))
range6 <- colRanges(data.matrix(data6))

Nrows <- dim(data1)[1]
Ncol1 <- dim(data1)[2]
Ncol2 <- dim(data2)[2]
Ncol3 <- dim(data3)[2]
Ncol4 <- dim(data4)[2]
Ncol5 <- dim(data5)[2]
Ncol6 <- dim(data6)[2]

#Create weight vectors
w1 = c(1:Ncol1)
w2 = c(1:Ncol2)
w3 = c(1:Ncol3)
w4 = c(1:Ncol4)
w5 = c(1:Ncol5)
w6 = c(1:Ncol6)

invertLog10 <- function(x) { if(x$p.value==0){-1*log10(0.001)} else {-1*log10(x$p.value)} }

for (j in 1:Ncol1){
  yy = ecdf(range1[j,1]:range1[j,2])
  xx = ks.test(data1[,j],yy)
  w1[j] = invertLog10(xx)
}
w1 <- w1/sum(w1)

for (j in 1:Ncol2){
  yy = ecdf(range2[j,1]:range2[j,2])
  xx = ks.test(data2[,j],yy)
  w2[j] = invertLog10(xx)
}
w2 <- w2/sum(w2)

for (j in 1:Ncol3){
  yy = ecdf(range3[j,1]:range3[j,2])
  xx = ks.test(data3[,j],yy)
  w3[j] = invertLog10(xx)
}
w3 <- w3/sum(w3)

for (j in 1:Ncol4){
  yy = ecdf(range4[j,1]:range4[j,2])
  xx = ks.test(data4[,j],yy)
  w4[j] = invertLog10(xx)
}
w4 <- w4/sum(w4)

for (j in 1:Ncol5){
  yy = ecdf(range5[j,1]:range5[j,2])
  xx = ks.test(data5[,j],yy)
  w5[j] = invertLog10(xx)
}
w5 <- w5/sum(w5)

for (j in 1:Ncol6){
  yy = ecdf(range6[j,1]:range6[j,2])
  xx = ks.test(data6[,j],yy)
  w6[j] = invertLog10(xx)
}
w6 <- w6/sum(w6)
