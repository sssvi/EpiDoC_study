library(factoextra)
library(fpc)
library(dbscan)
library(standardize)
library(optimbase)
library(clusterCrit)

bigdataDB = read.table("data.txt", fill = TRUE , header = TRUE )
bigdataDBID = read.table("data_ID.txt", fill = TRUE , header = TRUE )

dataNoOutliers <- bigdataDB
print(dim(bigdataDB))
print(dim(bigdataDBID))

bigdataDB[is.na(bigdataDB)] <- -1

#distdata = dist(bigdataDB,  method = "euclidean")
distdata = dist(bigdataDB,  method = "manhattan")

#RESTART FROM HERE!!!!
dbscan::kNNdistplot(distdata, k = 3)
abline(h = 350, lty = 2)
abline(h = 300, lty = 2)
abline(h = 35, lty = 2)

res.fpc <- fpc::dbscan(distdata, eps = 350, MinPts = 3, scale=FALSE, method="dist")
# dbscan package
#res.db <- dbscan::dbscan(distdata, 35, 3)

#all(res.fpc$cluster == res.db)

fviz_cluster(res.fpc, distdata, geom = "point")
#fviz_cluster(res.db, distdata, geom = "point")

print(res.fpc)
#print(res.db)

DBSCAN_stats <- cluster.stats(d = distdata, clustering = res.fpc$cluster)
DBSCAN_stats$cluster.size
DBSCAN_stats$clus.avg.silwidths
DBSCAN_stats$dunn

#DBSCAN_statsEx <- intCriteria(distdata, res.fpc$cluster, c("Silhouette", "Dunn", "PBM", "Davies_Bouldin"))
#print(DBSCAN_statsEx$silhouette)
#print(DBSCAN_statsEx$dunn)
#print(DBSCAN_statsEx$pbm)
#print(DBSCAN_statsEx$davies_bouldin)

to.remove <- which(res.fpc$cluster==0)
print(to.remove)
print(length(to.remove))

for( k in to.remove){
  dataNoOutliers = dataNoOutliers[-c(k),]
  #bigdataDBID = bigdataDBID[-k]
}

print(dim(dataNoOutliers))
print(dim(bigdataDBID))

to.remove = transpose(to.remove)
write(to.remove, "~/abSNFmaster/outliers_man.txt", append = FALSE, sep = "\n")

